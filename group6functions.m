function group6()

    clc;

    % anonymous functions 
    f   = @(x) x.^3 - 4*x - 9;
    df  = @(x) 3*x.^2 - 4;
    g   = @(x) (4*x + 9).^(1/3);
    ode = @(x,y) 0.8*x + 1.2*y;

    tol   = 1e-4;
    label = '';

    %% Bisection
    label = 'BISECTION (while)';
    [r, n] = bisectionWhile(f, 2, 3, tol, 100);   showRoot(r, n);

    label = 'BISECTION (for)';
    [r, n] = bisectionFor(f, 2, 3, tol, 20);      showRoot(r, n);

    label = 'BISECTION (recursive)';
    fprintf('Bisection (recursive)\niter\tc\t\tf(c)\n');
    [r, n] = bisectionRecursive(f, 2, 3, tol, 0); showRoot(r, n);

    %% Newton-Raphson
    label = 'NEWTON (while)';
    [r, n] = newtonWhile(f, df, 2.5, tol, 100);   showRoot(r, n);

    label = 'NEWTON (for)';
    [r, n] = newtonFor(f, df, 2.5, tol, 10);      showRoot(r, n);

    %% Secant
    label = 'SECANT (while)';
    [r, n] = secantWhile(f, 2, 3, tol, 100);      showRoot(r, n);

    label = 'SECANT (for)';
    [r, n] = secantFor(f, 2, 3, tol, 10);         showRoot(r, n);

    %% Fixed point iteration
    label = 'FIXED POINT (while)';
    [r, n] = fixedPointWhile(f, g, 2.5, tol, 100); showRoot(r, n);

    label = 'FIXED POINT (for)';
    [r, n] = fixedPointFor(f, g, 2.5, tol, 20);    showRoot(r, n);

    %% Euler
    [y, n] = eulerWhile(ode, 0, 0.5, 0.25, 1);
    fprintf('EULER (while): final y(1) = %.6f after %d steps\n\n', y, n);

    [y, n] = eulerFor(ode, 0, 0.5, 0.25, 1);
    fprintf('EULER (for): final y(1) = %.6f after %d steps\n\n', y, n);

    %% Runge-Kutta 4
    [y, n] = rk4While(ode, 0, 0.5, 0.25, 1);
    fprintf('RK4 (while): final y(1) = %.6f after %d steps\n\n', y, n);

    [y, n] = rk4For(ode, 0, 0.5, 0.25, 1);
    fprintf('RK4 (for): final y(1) = %.6f after %d steps\n\n', y, n);

    % nested function
    % Uses f, tol and label directly from the main function's workspace.
    function showRoot(root, iters)
        fprintf('%s: root = %.6f, |f(root)| = %.2e, tol = %g, after %d iters\n\n', ...
                label, root, abs(f(root)), tol, iters);
    end
end


%% LOCAL FUNCTIONS

% Bisection 
function [c, iter] = bisectionWhile(f, a, b, tol, maxiter)
    iter = 0;
    if f(a)*f(b) >= 0
        error('invalid interval [a,b]');
    end
    fprintf('Bisection (while)\niter\tc\t\tf(c)\n');
    c  = (a + b)/2;
    fc = f(c);
    while (abs(fc) >= tol) && ((b - a)/2 >= tol) && (iter < maxiter)
        iter = iter + 1;
        fprintf('%d\t%.6f\t%.6f\n', iter, c, fc);
        if f(a)*fc < 0
            b = c;
        else
            a = c;
        end
        c  = (a + b)/2;
        fc = f(c);
    end
end

function [c, iter] = bisectionFor(f, a, b, tol, maxiter)
    if f(a)*f(b) >= 0
        error('invalid interval [a,b]');
    end
    fprintf('Bisection (for)\niter\tc\t\tf(c)\n');
    for iter = 1:maxiter
        c  = (a + b)/2;
        fc = f(c);
        fprintf('%d\t%.6f\t%.6f\n', iter, c, fc);
        if abs(fc) < tol || (b - a)/2 < tol
            break
        end
        if f(a)*fc < 0
            b = c;
        else
            a = c;
        end
    end
end

% Recursive function
function [c, iter] = bisectionRecursive(f, a, b, tol, iter)
    if f(a)*f(b) >= 0
        error('invalid interval [a,b]');
    end
    c  = (a + b)/2;
    fc = f(c);
    iter = iter + 1;
    fprintf('%d\t%.6f\t%.6f\n', iter, c, fc);
    if abs(fc) < tol || (b - a)/2 < tol     % base case
        return
    end
    if f(a)*fc < 0                          % recursive case: half the interval
        [c, iter] = bisectionRecursive(f, a, c, tol, iter);
    else
        [c, iter] = bisectionRecursive(f, c, b, tol, iter);
    end
end

% Newton-Raphson 
function [x0, iter] = newtonWhile(f, df, x0, tol, maxiter)
    iter = 0;
    fprintf('Newton (while)\niter\tx0\t\tx1\t\tf(x1)\n');
    while (abs(f(x0)) >= tol) && (iter < maxiter)
        iter = iter + 1;
        if abs(df(x0)) < 1e-12
            error('f''(x) = 0');
        end
        x1 = x0 - f(x0)/df(x0);
        fprintf('%d\t%.6f\t%.6f\t%.6f\n', iter, x0, x1, f(x1));
        x0 = x1;
    end
end

function [x1, iter] = newtonFor(f, df, x0, tol, maxiter)
    fprintf('Newton (for)\niter\tx0\t\tx1\t\tf(x1)\n');
    x1 = x0;
    for iter = 1:maxiter
        if abs(df(x0)) < 1e-12
            error('f''(x) = 0, division by zero');
        end
        x1 = x0 - f(x0)/df(x0);
        fprintf('%d\t%.6f\t%.6f\t%.6f\n', iter, x0, x1, f(x1));
        if abs(f(x1)) < tol || abs(x1 - x0) < tol
            break
        end
        x0 = x1;
    end
end

% Secant
function [x1, iter] = secantWhile(f, x0, x1, tol, maxiter)
    iter = 0;
    dx   = inf;
    fprintf('Secant (while)\niter\tx0\t\tx1\t\tx2\t\tf(x2)\n');
    while (abs(f(x1)) >= tol) && (dx >= tol) && (iter < maxiter)
        iter = iter + 1;
        if abs(f(x1) - f(x0)) < 1e-12
            error('division by zero');
        end
        x2 = x1 - f(x1)*(x1 - x0)/(f(x1) - f(x0));
        dx = abs(x2 - x1);
        fprintf('%d\t%.6f\t%.6f\t%.6f\t%.6f\n', iter, x0, x1, x2, f(x2));
        x0 = x1;
        x1 = x2;
    end
end

function [x2, iter] = secantFor(f, x0, x1, tol, maxiter)
    fprintf('Secant (for)\niter\tx0\t\tx1\t\tx2\t\tf(x2)\n');
    x2 = x1;
    for iter = 1:maxiter
        if abs(f(x1) - f(x0)) < 1e-12
            error('division by zero');
        end
        x2 = x1 - f(x1)*(x1 - x0)/(f(x1) - f(x0));
        fprintf('%d\t%.6f\t%.6f\t%.6f\t%.6f\n', iter, x0, x1, x2, f(x2));
        if abs(f(x2)) < tol || abs(x2 - x1) < tol
            break
        end
        x0 = x1;
        x1 = x2;
    end
end

%Fixed point iteration
function [x0, iter] = fixedPointWhile(f, g, x0, tol, maxiter)
    iter = 0;
    dx   = inf;
    fprintf('Fixed point (while)\niter\tx0\t\tx1\t\tf(x1)\n');
    while (abs(f(x0)) >= tol) && (dx >= tol) && (iter < maxiter)
        iter = iter + 1;
        x1 = g(x0);
        dx = abs(x1 - x0);
        fprintf('%d\t%.6f\t%.6f\t%.6f\n', iter, x0, x1, f(x1));
        x0 = x1;
    end
end

function [x1, iter] = fixedPointFor(f, g, x0, tol, maxiter)
    fprintf('Fixed point (for)\niter\tx0\t\tx1\t\tf(x1)\n');
    x1 = x0;
    for iter = 1:maxiter
        x1 = g(x0);
        fprintf('%d\t%.6f\t%.6f\t%.6f\n', iter, x0, x1, f(x1));
        if abs(x1 - x0) < tol || abs(f(x1)) < tol
            break
        end
        x0 = x1;
    end
end

%Euler
function [y, iter] = eulerWhile(f, x0, y0, h, x_end)
    x = x0;  y = y0;  iter = 0;
    fprintf('Euler (while)\niter\tx\t\ty\t\tf(x,y)\n');
    fprintf('%d\t%.2f\t%.6f\t%.6f\n', iter, x, y, f(x, y));
    while x < x_end - 1e-9
        iter = iter + 1;
        y_new = y + h*f(x, y);
        x = x + h;
        y = y_new;
        fprintf('%d\t%.2f\t%.6f\t%.6f\n', iter, x, y, f(x, y));
    end
end

function [y, n] = eulerFor(f, x0, y0, h, x_end)
    n = round((x_end - x0)/h);
    x = x0;  y = y0;
    fprintf('Euler (for)\niter\tx\t\ty\t\tf(x,y)\n');
    fprintf('0\t%.2f\t%.6f\t%.6f\n', x, y, f(x, y));
    for i = 1:n
        y = y + h*f(x, y);
        x = x + h;
        fprintf('%d\t%.2f\t%.6f\t%.6f\n', i, x, y, f(x, y));
    end
end

%Runge-Kutta 4
function [y, iter] = rk4While(f, x0, y0, h, x_end)
    x = x0;  y = y0;  iter = 0;
    fprintf('RK4 (while)\niter\tx\t\ty\t\tf(x,y)\n');
    fprintf('%d\t%.2f\t%.6f\t%.6f\n', iter, x, y, f(x, y));
    while x < x_end - 1e-9
        iter = iter + 1;
        k1 = f(x, y);
        k2 = f(x + h/2, y + h*k1/2);
        k3 = f(x + h/2, y + h*k2/2);
        k4 = f(x + h,   y + h*k3);
        y = y + h*(k1 + 2*k2 + 2*k3 + k4)/6;
        x = x + h;
        fprintf('%d\t%.2f\t%.6f\t%.6f\n', iter, x, y, f(x, y));
    end
end

function [y, n] = rk4For(f, x0, y0, h, x_end)
    n = round((x_end - x0)/h);
    x = x0;  y = y0;
    fprintf('RK4 (for)\niter\tx\t\ty\t\tf(x,y)\n');
    fprintf('0\t%.2f\t%.6f\t%.6f\n', x, y, f(x, y));
    for i = 1:n
        k1 = f(x, y);
        k2 = f(x + h/2, y + h*k1/2);
        k3 = f(x + h/2, y + h*k2/2);
        k4 = f(x + h,   y + h*k3);
        y = y + h*(k1 + 2*k2 + 2*k3 + k4)/6;
        x = x + h;
        fprintf('%d\t%.2f\t%.6f\t%.6f\n', i, x, y, f(x, y));
    end
end
