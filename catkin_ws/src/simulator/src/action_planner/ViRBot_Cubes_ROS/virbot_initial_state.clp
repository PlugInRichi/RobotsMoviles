
;************************************************
;*						*
;*	Initial state 				*
;*						*
;*                      J.Savage, UNAM          *
;*						*
;*                      1/5/20                  *
;*                                              *
;************************************************




(deffacts Initial-state-objects-rooms-zones-actors

; Rooms definitions
	( Room (name kitchen) (zone fridge_zone)							(zones dummy1 frontexit frontentrance fridge_zone dummy2)(center 1.70 1.60))
	( Room (name service) (zone service_zone)			(zones dummy1 frontexit frontentrance service_zone dummy2)(center 1.65 0.55))
	( Room (name corridor)(zone entry)							(zones dummy1 frontexit frontentrance entry dummy2)(center 0.5 1.05))

; Objects definitions
<<<<<<< HEAD
	( item (type Objects) (name Appl)	(room corridor)(zone entry)	(image Appl)	(attributes pick)(pose 0.46 1.12 0.0))
	( item (type Objects) (name Sush)	(room corridor)(zone entry)	(image Sush)	(attributes pick)(pose 0.32 1.12 0.0))
	( item (type Objects) (name Milk)	(room corridor)(zone entry)	(image Milk)	(attributes pick)(pose 0.18 1.12 0.0))
	( item (type Objects) (name Soap)	(room corridor)(zone entry)	(image Soap)	(attributes pick)(pose 0.18 0.97 0.0))
	( item (type Objects) (name Perf)	(room corridor)(zone entry)	(image Perf)	(attributes pick)(pose 0.32 0.97 0.0))
	( item (type Objects) (name Sham)	(room corridor)(zone entry)	(image Sham)	(attributes pick)(pose 0.46 0.97 0.0))
	( item (type Objects) (name freespace)(room any)(zone any)(image none)(attributes none)(pose 0.0 0.0 0.0))

	; Robots definitions
	( item (type Robot) (name robot)(zone frontexit)(pose 2.05 2.05 0.0))

	; Furniture definitions
	( item (type Furniture) (name fridge)					(room kitchen)	(zone fridge_zone)	(image fridge)	( attributes no-pick brown)(pose 1.50 1.50 0.0))
	( item (type Furniture) (name service_table)	(room service)	(zone service_zone)	(image table)		( attributes no-pick brown)(pose 1.65 0.30 0.0))
=======
	( item (type Objects) (name fridge)(room kitchen)(image table)( attributes no-pick brown)(pose 6.183334 7.000000 0.0))
	( item (type Objects) (name storage)(room service)(image table)( attributes no-pick brown)(pose 3.183334 2.000000 0.0))
	( item (type Objects) (name deposit)(room corridor)(image table)( attributes no-pick brown)(pose 3.183334 2.000000 0.0))
	( item (type Objects) (name Appl)(room corridor)(zone deposit)(image Appl)(attributes pick)(pose .46 1.12 0.0))
	( item (type Objects) (name Sush)(room corridor)(zone deposit)(image Sush)(attributes pick)(pose .32 1.12 0.0))
	( item (type Objects) (name Milk)(room corridor)(zone deposit)(image Milk)(attributes pick)(pose .18 1.12 0.0))
	( item (type Objects) (name Soap)(room corridor)(zone deposit)(image Soap)(attributes pick)(pose .18 .97 0.0))
	( item (type Objects) (name Perf)(room corridor)(zone deposit)(image Perf)(attributes pick)(pose .32 .97 0.0))
	( item (type Objects) (name Sham)(room corridor)(zone deposit)(image Sham)(attributes pick)(pose .46 .97 0.0))
	( item (type Objects) (name freespace)(room any)(zone any)(image none)(attributes none)(pose 0.0 0.0 0.0))

; Rooms definitions
	( Room (name corridor)(zone deposit)(zones dummy1 frontexit frontentrance deposit dummy2)(center 0.6 1.05))
	( Room (name kitchen)(zone fridge)(zones dummy1 frontexit frontentrance fridge dummy2)(center 1.5 1.4))
	( Room (name service)(zone storage)(zones dummy1 frontexit frontentrance storage dummy2)(center 1.65 0.55))

; Robots definitions
	( item (type Robot) (name robot)(zone frontexit)(pose 1.048340 1.107002 0.0))

; Furniture definitions
	( item (type Furniture) (name cubestable)(zone kitchen)(image table)( attributes no-pick brown)(pose 6.183334 7.000000 0.0))
>>>>>>> 150292dee6fc1644119ea661fad2c9072ac4d099

	; Doors definitions
	( item (type Door) (name outsidedoor) (status closed) )
	( Arm (name left))

<<<<<<< HEAD
	;Posición de los objetos, el primero está en la cima
	(stack corridor entry entryObj Appl Sush Milk)
	(stack corridor entry entryObj Soap Perf Sham)

	(real-stack corridor entry entryObj Appl Sush Milk)
	(real-stack corridor entry entryObj Soap Perf Sham)

	;A donde deben ser llevados, el último elemento es el tope de la pila (primero en llevar)
	(goal-stack 1 service service_zone service_table Soap Perf Sham)
	(goal-stack 1 kitchen fridge_zone fridge Sush Appl Milk)

=======
;stacks definitions
(stack corridor deposit Appl Sush Milk)
(stack corridor deposit Sham Perf Soap)

(real-stack corridor deposit Appl Sush Milk)
(real-stack corridor deposit Sham Perf Soap)

(goal-stack 1 kitchen fridge Milk Sush Appl)
(goal-stack 2 service storage Soap Perf Sham)
>>>>>>> 150292dee6fc1644119ea661fad2c9072ac4d099


	;No sé para qué, pero si no está no se mueve
	(plan (name cubes) (number 0)(duration 0))
)
