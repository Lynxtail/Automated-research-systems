% 3 вариант

function PDETEst
    R = 10;% Константа в (1.6)
    a = 0.5;% Константа в (1.8)
    x_mesh = 0.05 * (0:20);% Узлы пространственной сетки
    t_span = 0.1 * (0:10);% Начальное значение времени 0 и дальнейшие
    t_span(12:21) = 1 + 0.2 * (1:10);% нужные значения времени
    t_span(22:25) = [3.5, 4, 4.5, 5];
    
    %Вызов стандартной функции MATLAB для решения
    %начально-краевой задачи для одномерных нелинейных
    %уравнений в частных производных параболического типа
    
    sol = pdepe(0,...%означает, что задача решается в Декартовых коорд. 
          @pdefun,...%дескриптор ф-ии, кодирующей само ур-ие в частн. произв.
          @icfun,...%дескриптор ф-ии, кодирующей зависимость н.у. от x
          @bcfun,...%дескриптор ф-ии, кодирующей граничные условия
          x_mesh,...%пространственная сетка
          t_span);%0 + набор нужных значений времени
    
    % Сравнение точного и приближенного решений  
    for k = 2:size(t_span, 2)% по всем моментам времени, кроме начального нулевого
        disp(sprintf('t = %.3f', t_span(k)));
        UU = FFi(a + x_mesh, log((1 + exp(t_span(k))) / 2));%расчет точного решения в узлах сетки
        disp('Приближенное - Точное');
        for j = 1:size(x_mesh, 2)
            disp(sprintf('%f\t%f', sol(k,j), UU(j)));
        end
        disp('-------------------------------------------');
    end

    %---------------------------------------------------
    %графическое отображение решения
    figure; surf(x_mesh, t_span, sol);
    xlabel('x');
    ylabel('t');
    
    %---------------------------------
    %Собственно уравнение в частных производных
     function [c, f, s] = pdefun(x, t, u, dudx)
         f = dudx / R;
         s = -u .* dudx;
         % (1 + exp(t)) * u* = f + s + c
         c = 1 / (1 + exp(-t));
     end

    %-------------------------------
    %Начальные условия
    function u = icfun(x)
        u = 0;
    end

    %-------------------------------
    %Граничные условия
     function [pl,ql,pr,qr] = bcfun(xl, ul, xr, ur, t)
         pl = ul - FFi(a, log((1 + exp(t)) / 2)); %При x=0
         ql = 0;
         pr = ur - FFi(1 + a, log((1 + exp(t)) / 2)); %При x=1
         qr = 0;
     end
    
    %-----------------------------------------------------
    function u = FFi(x, t) % Формула (1.3)
        if t > 0.01       % при x>0
           T1 = erfc(0.5 * (x - t) * sqrt(R / t));
           T2 = erfc(0.5 * x * sqrt(R / t));
           u = T1 ./ (T1 + exp(0.25 * R * (2 * x - t)) .* (1 - T2));
        else
            u = 0 * x;
        end
    end
    %--------------------------------
end