
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
	( item (type Objects) (name deposit)(room bedroom)(image table)( attributes no-pick brown)(pose 6.183334 7.000000 0.0))
	( item (type Objects) (name storage)(room livingroom)(image table)( attributes no-pick brown)(pose 3.183334 2.000000 0.0))
	( item (type Objects) (name blockA)(room bedroom)(zone deposit)(image blockA)(attributes pick)(pose .46 1.12 0.0))
	( item (type Objects) (name blockB)(room bedroom)(zone deposit)(image blockB)(attributes pick)(pose .32 1.12 0.0))
	( item (type Objects) (name blockC)(room bedroom)(zone deposit)(image blockC)(attributes pick)(pose .18 1.12 0.0))
	( item (type Objects) (name blockD)(room livingroom)(zone storage)(image blockD)(attributes pick)(pose .18 .97 0.0))
	( item (type Objects) (name blockE)(room livingroom)(zone storage)(image blockE)(attributes pick)(pose .32 .97 0.0))
	( item (type Objects) (name blockF)(room livingoom)(zone storage)(image blockF)(attributes pick)(pose .46 .97 0.0))
	( item (type Objects) (name freespace)(room any)(zone any)(image none)(attributes none)(pose 0.0 0.0 0.0))

; Rooms definitions
	( Room (name livingroom)(zone storage)(zones dummy1 frontexit frontentrance storage dummy2)(center 0.50 0.80))
	( Room (name kitchen)(zone deposit)(zones dummy1 frontexit frontentrance deposit dummy2)(center 0.45 0.20))
	( Room (name bedroom)(zone deposit)(zones dummy1 frontexit frontentrance deposit dummy2)(center 0.4 0.10))

; Robots definitions
	( item (type Robot) (name robot)(zone frontexit)(pose 1.048340 1.107002 0.0))

; Furniture definitions
	( item (type Furniture) (name cubestable)(zone bedroom)(image table)( attributes no-pick brown)(pose 6.183334 7.000000 0.0))

; Doors definitions
	( item (type Door) (name outsidedoor) (status closed) )

	( Arm (name left))

;stacks definitions
(stack corridor deposit blockC blockB blockA)
(stack corridor storage blockD blockE blockF)

(real-stack corridor deposit blockC blockB blockA)
(real-stack corridor storage blockD blockE blockF)

(goal-stack 1 kitchen deposit blockA blockB blockC)
(goal-stack 2 studio storage blockF blockE blockD)

(plan (name cubes) (number 0)(duration 0))

)
