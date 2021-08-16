
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


; Objects definitions
	( item (type Objects) (name fridge)(room kitchen)(image table)( attributes no-pick brown)(pose 6.183334 7.000000 0.0))
	( item (type Objects) (name storage)(room service)(image table)( attributes no-pick brown)(pose 3.183334 2.000000 0.0))
	( item (type Objects) (name deposit)(room corridor)(image table)( attributes no-pick brown)(pose 3.183334 2.000000 0.0))
	( item (type Objects) (name blockA)(room corridor)(zone deposit)(image blockA)(attributes pick)(pose .46 1.12 0.0))
	( item (type Objects) (name blockB)(room corridor)(zone deposit)(image blockB)(attributes pick)(pose .32 1.12 0.0))
	( item (type Objects) (name blockC)(room corridor)(zone deposit)(image blockC)(attributes pick)(pose .18 1.12 0.0))
	( item (type Objects) (name blockD)(room corridor)(zone deposit)(image blockD)(attributes pick)(pose .18 .97 0.0))
	( item (type Objects) (name blockE)(room corridor)(zone deposit)(image blockE)(attributes pick)(pose .32 .97 0.0))
	( item (type Objects) (name blockF)(room corridor)(zone deposit)(image blockF)(attributes pick)(pose .46 .97 0.0))
	( item (type Objects) (name freespace)(room any)(zone any)(image none)(attributes none)(pose 0.0 0.0 0.0))

; Rooms definitions
	( Room (name corridor)(zone deposit)(zones dummy1 frontexit frontentrance deposit dummy2)(center 0.6 1.05))
	( Room (name kitchen)(zone fridge)(zones dummy1 frontexit frontentrance fridge dummy2)(center 1.5 1.4))
	( Room (name service)(zone storage)(zones dummy1 frontexit frontentrance storage dummy2)(center 1.65 0.55))

; Robots definitions
	( item (type Robot) (name robot)(zone frontexit)(pose 1.048340 1.107002 0.0))

; Furniture definitions
	( item (type Furniture) (name cubestable)(zone kitchen)(image table)( attributes no-pick brown)(pose 6.183334 7.000000 0.0))

; Doors definitions
	( item (type Door) (name outsidedoor) (status closed) )

	( Arm (name left))

;stacks definitions
(stack corridor deposit blockA blockB blockC)
(stack corridor deposit blockF blockE blockD)

(real-stack corridor deposit blockA blockB blockC)
(real-stack corridor deposit blockF blockE blockD)

(goal-stack 1 kitchen fridge blockC blockB blockA)
(goal-stack 2 service storage blockD blockE blockF)

(plan (name cubes) (number 0)(duration 0))

)
