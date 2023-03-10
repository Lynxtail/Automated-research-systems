function Stiff_ODE
Tmax=25;% ???????????? ???????? ???????
Tspan=(0:200)*(Tmax/200);% ??? ???? ???????? ??????? ????????? ???????
tic;% ?????? ?????? ???????
%????? ?????????? ?????? ????. ??????? ??? (????-??????? ????? ??????)
%T - ????? ???????? ???????, ??????????? ??????
%Y - ???????, ?????? ?????? ??????? ?????. ??????? ? ?????? ??????? ??
%?????. ?????? T
[T,Y]=ode113(@ODE_Fun,...%?????? ????? ??????? ???
             Tspan,...%??? ???? ???????? ??????? ????????? ???????
             [0; 0; 0; 0]);%??????? ????????? ???????
toc;% ????? ?????? ???????
figure; plot(T, Y(:,1));% ??????. ??????????? ??????????? y1(t)
tic;% ?????? ?????? ???????
%????? ???????? ?????? ????. ??????? ??? (???-?????)
%T - ????? ???????? ???????, ??????????? ??????
%Y - ???????, ?????? ?????? ??????? ?????. ??????? ? ?????? ??????? ??
%?????. ?????? T
[T,Y]=ode15s(@ODE_Fun,...%?????? ????? ??????? ???
             Tspan,...%??? ???? ???????? ??????? ????????? ???????
             [0; 0; 0; 0]);%??????? ????????? ???????
toc; % ????? ?????? ???????
figure; plot(T, Y(:,1));% ??????. ??????????? ??????????? y1(t)
end


function f=Fun(y)% ??????? f(y) ? ?????? ????? (1)
f=[0.02*y(1)*y(2);
   0.02*y(1)*y(1);
   y(1)*y(3);
   y(2)*y(4)];
end

function x=x_Fun(t)% ??????? x(t) ? ?????? ????? (1)
    x=[exp(-t); 1; 0; 0];
end

function F=ODE_Fun(t,y)% ?????????? ?????? ????? (1)
    A=[0.01    1    -0.01    0.01;...% ??????? A ? ?????? ????? (1)
         -1   -0.2    0.01   -0.01;...
        100  -2000   700     1.0e5;...
       700   3000  -1.0e5  -1.0e5];
    F=A*y+x_Fun(t)+Fun(y);
end
