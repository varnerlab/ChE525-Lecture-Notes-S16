% Script to calculate flux vector using MFA -

STM = [ ...
-1  -1	0 1	 ; % A
1	0	1 -1	   ; % B
0	1	-1	0    ; % C
];

TM = [ ...
	1	0	0	     ; % A
	0	-1 0	   ; % B
	0	0	-1	   ; % C
];

% Assume we selected q1 and q2 as *measured*
STM_NEW = [STM(:,[1,2,3]) TM(:,3)];
TM_NEW = [TM(:,1:2) STM(:,4)];

% Compute the right inverse -
COND = det(STM_NEW*transpose(STM_NEW));
RINV = transpose(STM_NEW)*inv(STM_NEW*transpose(STM_NEW));

% What is my measured values?
vm = [ ...
	1.0 	;	% q_1 measured
	0.5 	;	% q_2 measured
  0.0   ; % v_4 measured
];

% Compute my unmeasured fluxes -
bVector = -1*TM_NEW*vm;
vu = RINV*bVector;

% Is this a good solution?
ERROR = STM_NEW*vu + TM_NEW*vm;
