;var = num in group = 17:
	;even, num of proc = 1, Nint >= Dx (-), Nint < Dx (+), Lgi <= Xmin (-) 1st or any left bord
	;Lg1 > Xmin (+), Right border of last interval <= Xmax (-), RBlin > Xmax (+)
;Use C to get the initial values and check them, also to generate rand nums 
;then call 1 masm proc to sort nums -> if they are in the acceplable interval or not
	;call masm proc as a separate module, pass vals through stack snapshot-???
;Initial vals are:
	;Arr length NumRanDat <= 16K
	;Interval Xmin & Xmax from where random numbers will be taken 
	;Arr of rand int nums (Xi)
	;Amount of intervals the [Xmin, Xmax] will be broken into - Nint <= 24
	;Arr of left borders of intervals(Nint) - LGrInt
;Result output - text table with:
	;num of the interval
	;left border of interval
	;amount of rand nums in this interval
		;n of strings == amont of intervals overall
		;table must be printed on screen and saved into file
;because num of proc = 1 -> it forms distribution of init vals inside the intervals and rets it
;Number of intervals cannot be >= the interval [Xmin, Xmax]
;Left border can be bigger than Xmin, but not less
;Right border can be bigger than Xmax, but not <=

;----------------PROG:------

