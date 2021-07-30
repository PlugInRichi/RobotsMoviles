/********************************************************
 *                                                      *
 *                                                      *
 *      user_sm.h			          	*
 *                                                      *
 *							*
 *		FI-UNAM					*
 *		17-2-2019                               *
 *                                                      *
 ********************************************************/
#include <vector>
#include <math.h>
const float PI = 3.1415926535;
const int th_min = 0.04;
std::vector<float> qn = {0,0};
std::vector<float> qd = {0,0};
std::vector<float> destinos [8] = {{0.01,1},{-0.707,0.707},{-1,0.01},{-0.707,-0.707},
																		{0.01,-1},{0.707,-0.707},{1,0.01},{0.707,0.707}};
//std::vector<float> forces [2] = {{0,0},{0,0}};
float calculateAngle(std::vector<float> fuerzas);
void calculateObjetive(float *light_values);
void normVector(float *observations, int size, float laser_value);
std::vector <float> calculateFuerzaRep(int size, float laser_value);
//void evaluateMinumum( std::vector<float> fuerzas, int *next_state);
//td::vector <float> lightVector(float *light_values);
 int max_ligth;//Index
 int max_observation; //Index
 float max_obs; //Value
 float ep = 0.9; //Constante de fuerza de atracción
 float delta = 0.025;
 float delta2 = 0.045;
 float eta = 3.5;//Constante de repulsión


// State Machine
void user_sm(float intensity, float *light_values, float *observations,
	int size, float laser_value, int  dest, int obs , movement *movements,
	int *next_state ,float Mag_Advance ,float max_twist){

 int state = *next_state;
 int i;

 std::vector<float> fAtrac;
 std::vector<float> fRep;
 std::vector<float> fuerzas;

 printf("intensity %f\n",intensity);
 printf("quantized destination %d\n",dest);
 printf("quantized obs %d\n",obs);
/*
 for(int i = 0; i < 8; i++)
        printf("light_values[%d] %f\n",i,light_values[i]);
 for (int i = 0; i < size ; i++ )
         printf("laser observations[%d] %f\n",i,observations[i]);
*/

	switch ( state ) {
		case 0:

		if (intensity > 40.0) {
			movements->twist = 0;
			movements->advance = 0; //delta
			printf("=================> Llegó <==============\n");
			break;
		}
		calculateObjetive(light_values);
		normVector(observations, size, laser_value);
		qd = destinos[max_ligth]; //Actualiza el destino
		printf("destinos %f %f\n", qd[0],qd[1]);
		fAtrac = {ep*(qn[0] + qd[0]), ep*(qn[1] + qd[1])}; //Calcula fuerza atracción
		fRep = calculateFuerzaRep(size, laser_value);
		fuerzas = {fAtrac[0]-fRep[0], fAtrac[1]-fRep[1]};
		printf("fuerzas %f %f\n", fuerzas[0], fuerzas[1]);


		movements->twist = calculateAngle(fuerzas);
		movements->advance = delta; //delta
		printf("=================> ESTADO 1 <==============\n");
		printf("El máximo, posición: %d \n", max_ligth);
		//evaluateMinumum(fuerzas, next_state);

		*next_state = 0;

		break;

 printf("Next State: %d\n", *next_state);
}
}

void calculateObjetive(float *light_values){
	float max_observation = 0.0;
	for (int i = 0; i < 8 ; i++ ){
		if (light_values[i] > max_observation) {
			max_observation = light_values[i];
			max_ligth = i;
		}
	}
}


/*
Calcula el ańgulo de giro entre el vector de dirección y el eje de referencia
del robot
*/
float calculateAngle(std::vector<float> fuerzas){
	float giro = atan2(fuerzas[1],fuerzas[0]) - PI/2 ; //Y,X
	//Elimina posibles medios giros, los giros deben ser menores a 3PI
	if (giro > PI) {
		giro = giro - PI;
	}else if(giro < -PI){
		giro = giro + PI;
	}
	printf("\n>>Cambio de ángulo %f \n\n",giro); //Padding de 90 para que no viaje perpendicular
	return (giro);
}



/*Calcula la fuerza repulsiva utiliando una aproximación del vector normal a el
obstaculo*/
std::vector <float> calculateFuerzaRep(int size, float laser_value){
	std::vector <float> fuerzaRep;
	if (max_obs == laser_value){
		fuerzaRep = {0,0};
		printf("No hay fuerza de repulsión\n");
	}else{
		float scale = PI /size;
		float angle = 0 + scale*max_observation;
		//float mag = eta*(1 - (max_obs/laser_value));
		float mag = eta*1;
		//Se normaliza a 1 y se aplica el coeficinete está invertido , cuando hay objeto decrementa
		fuerzaRep = {mag*(float)cos(angle), mag*(float)sin(angle)}; //Se añade un pad para que lo revote en digonal
		fuerzaRep[0] = fuerzaRep[0] == 0? eta*2 : fuerzaRep[0];
		fuerzaRep[1] = fuerzaRep[1] == 0? eta*2 : fuerzaRep[1];

		fuerzaRep[0] = fabs(fuerzaRep[0]) < 2? fuerzaRep[0]*1.5 : fuerzaRep[0];
		fuerzaRep[1] = fabs(fuerzaRep[1]) < 2? fuerzaRep[1]*1.5 : fuerzaRep[1];
		printf("Vector de repulsión %f %f\n", fuerzaRep[0], fuerzaRep[1]);
	}
	return fuerzaRep;
}

/*
Calcula el máximo y el mínimo para cada uno d elso sensores de proximidad
Aproxima el vector normal a el obstaculo usando el valor máximo.
*/
void normVector(float *observations, int size, float laser_value){
	max_obs = laser_value;
	for (int i = 0; i < size ; i++ ){
		if(observations[i] < max_obs){ //cuando se acerca a un obstaculo se hae pequeño
			max_observation = i;
			max_obs = observations[i];
		}
	}
	printf("max observation[%d] %f\n", max_observation, max_obs);
}


/*
std::vector <float> lightVector(float *light_values){
	float max_l, max_l2 = light_values[0];
	float max_lx,max_ly,max_lx2,max_ly2;
	int max_ligth, max_ligth_2 = 0;
	float mag,mag2;
	std::vector <float> dest;

	for (int i = 1; i < 8 ; i++ ){
		if (light_values[i] > max_l) {
			max_l2 = max_l;
			max_l = light_values[i];
			max_ligth_2 = max_ligth;
			max_ligth = i;
		}else if(light_values[i] > max_l2){
			max_l2 = light_values[i];
			max_ligth_2 = i;
		}
	}
	//Asignación del Vector
	if (max_ligth == max_ligth_2) {
		dest = destinos[max_ligth];
	}else{
		mag = max_l/max_l;
		mag2 = max_l2/max_l;
		max_lx = mag * cos(atan2(destinos[max_ligth_2][1],destinos[max_ligth][0]))
		max_ly
		max_lx2
		max_ly2
		dest = {destinos[max_ligth][0]+destinos[max_ligth_2][1],
			 			destinos[max_ligth][0]+destinos[max_ligth_2][1]};
	}
}*/
