% objective function vector
f=[21, 22.5, 22.5, 24.5, 23, 25.5, 1500, 2000, 3000];

% integer variables vector
intcon = [1,2,3,4,5,6,7,8,9];

% linear inequality constraints
A = [1	1	0	0	0	0	0	0	0
    0	0	1	1	0	0	0	0	0
    0	0	0	0	1	1	0	0	0
    -1	0	-1	0	-1	0	0	0	0
    0	-1	0	-1	0	-1	0	0	0
    1	1	0	0	0	0	-425	0	0
    0	0	1	1	0	0	0	-400	0
    0	0	0	0	1	1	0	0	-750
    -1	0	0	0	0	0	0	0	0
    0	-1	0	0	0	0	0	0	0
    0	0	-1	0	0	0	0	0	0
    0	0	0	-1	0	0	0	0	0
    0	0	0	0	-1	0	0	0	0
    0	0	0	0	0	-1	0	0	0];
 
b = [425, 400, 750, -550, -450, 0, 0, 0, 0, 0, 0, 0, 0, 0];

% bound constraints
lb = zeros(9,1);
ub = [Inf;Inf;Inf;Inf;Inf;Inf;1;1;1];

Aeq = [];
beq = [];

% start timer
tic;

% call intlinprog
[x,fval,exitflag,output] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);

% stop timer and print elapsed time
te = toc;

% ui figure
x_bar = categorical({'X-GE' 'X-KE' 'X-GT ' 'X-KT' 'X-GN' 'X-KN'});
y_bar = x(1:6);

fig = uifigure('Name','GoNuts 2 - Summary');
fig.Position(3:4) = [800 330];

uit = uitable(fig);
uit.ColumnName = {'Results','Values'};

% summary table
summary_table = {
    'Objective Function',fval;
    'X-GE',y_bar(1);
    'X-KE',y_bar(2);
    'X-GT',y_bar(3);
    'X-KT',y_bar(4);
    'X-GN',y_bar(5);
    'X-KN',y_bar(6);
    'Time Elapsed',te
    };

uit.Data = summary_table;
uit.ColumnSortable = true;
%uit.Position(3) = 300;

% bar graph
uiax = uiaxes(fig);
uiax.Position(1) = 360;
bar(uiax,x_bar,y_bar);



