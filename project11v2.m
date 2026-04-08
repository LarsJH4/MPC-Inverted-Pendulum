%% Code for MPC project
clear; clc; close all;
addpath(genpath('C:\...')) %Path to tbxmanager
addpath(genpath('C:\...')) %Path to Yalmip
rng(1);

%% RunMode
runMode = 'set1'; % 'set1', 'set2', 'set12', 'lqr', 'set1lqr', 'set4', 'set5', 'set124', 'set1245'
distnoise = false; % if true adds disturbance/noise
computeROA = false; % if true computes and plots viability slice
xfprojplot = false; % if true plots Xf
doAnimation = false; % if true shows animation


%% Parameters
M = 1.0;
m = 0.5;
l = 0.5;
I = m*l^2/12;
b = 0.1;
g = 9.81;

%% Configurations
cfg(1).name = 'Set 1';
cfg(1).Ts   = 0.05;
cfg(1).Aref = 0.25;
cfg(1).fref = 0.05;
cfg(1).duty = 50;
cfg(1).xref_offset = 0.0;

cfg(1).N = 50;
cfg(1).Q = diag([5, 1, 20, 1]);
cfg(1).R = 0.01;
cfg(1).Rdu = 0.5;

cfg(1).x_max_cart      = 0.5;
cfg(1).x_max_cartdot   = 2.0;
cfg(1).x_max_theta_err = deg2rad(10);
cfg(1).x_max_thetadot  = deg2rad(120);
cfg(1).u_max = 5;

cfg(1).xf_max_cart      = 0.05;
cfg(1).xf_max_cartdot   = 0.15;
cfg(1).xf_max_theta_err = deg2rad(2);
cfg(1).xf_max_thetadot  = deg2rad(20);

cfg(1).Tsim = 25;
cfg(1).x0   = [0.0; 0.0; pi + deg2rad(8); 0.0];

cfg(1).d_true   = 0.25;
cfg(1).sigma_v  = [1e-3; 2.5e-3; 1e-3; 2.5e-3];
cfg(1).obsPoles = [0.50 0.55 0.60 0.65 0.90];


%Set 2
cfg(2).name = 'Set 2';
cfg(2).Ts   = 0.05;
cfg(2).Aref = 0.25;
cfg(2).fref = 0.05;
cfg(2).duty = 50;
cfg(2).xref_offset = 0.0;

cfg(2).N = 50;
cfg(2).Q = diag([5, 1, 20, 1]);
cfg(2).R = 0.01;
cfg(2).Rdu = 0.50;

cfg(2).x_max_cart      = 0.5;
cfg(2).x_max_cartdot   = 2.0;
cfg(2).x_max_theta_err = deg2rad(10);
cfg(2).x_max_thetadot  = deg2rad(120);
cfg(2).u_max = 5;

cfg(2).xf_max_cart      = 0.05;
cfg(2).xf_max_cartdot   = 0.15;
cfg(2).xf_max_theta_err = deg2rad(2);
cfg(2).xf_max_thetadot  = deg2rad(20);

cfg(2).Tsim = 25;
cfg(2).x0   = [0.0; 0.0; pi + deg2rad(8); 0.0];

cfg(2).d_true   = 0.25;
cfg(2).sigma_v  = [1e-3; 2.5e-3; 1e-3; 2.5e-3];
cfg(2).obsPoles = [0.50 0.55 0.60 0.65 0.93];


%Set 3 (lqr)
cfg(3).name = 'Set 3';
cfg(3).Ts   = 0.05;
cfg(3).Aref = 0.25;
cfg(3).fref = 0.05;
cfg(3).duty = 50;
cfg(3).xref_offset = 0.0;
cfg(3).bipolar = true;

cfg(3).N = 50;
cfg(3).Q = diag([5, 1, 20, 1]);
cfg(3).R = 0.01;

cfg(3).x_max_cart      = 0.5;
cfg(3).x_max_cartdot   = 2.0;
cfg(3).x_max_theta_err = deg2rad(10);
cfg(3).x_max_thetadot  = deg2rad(120);
cfg(3).u_max = 25;

cfg(3).xf_max_cart      = 0.05;
cfg(3).xf_max_cartdot   = 0.15;
cfg(3).xf_max_theta_err = deg2rad(2);
cfg(3).xf_max_thetadot  = deg2rad(20);

cfg(3).Tsim = 25;
cfg(3).x0   = [0.0; 0.0; pi + deg2rad(8); 0.0];


%Set 4
cfg(4).name = 'Set 4';
cfg(4).Ts   = 0.05;
cfg(4).Aref = 0.25;
cfg(4).fref = 0.05;
cfg(4).duty = 50;
cfg(4).xref_offset = 0.0;

cfg(4).N = 50;
cfg(4).Q = diag([5, 1, 20, 1]);
cfg(4).R = 0.01;
cfg(4).Rdu = 0.5;

cfg(4).x_max_cart      = 0.5;
cfg(4).x_max_cartdot   = 2.0;
cfg(4).x_max_theta_err = deg2rad(10);
cfg(4).x_max_thetadot  = deg2rad(120);
cfg(4).u_max = 5;

cfg(4).xf_max_cart      = 0.05;
cfg(4).xf_max_cartdot   = 0.15;
cfg(4).xf_max_theta_err = deg2rad(2);
cfg(4).xf_max_thetadot  = deg2rad(20);

cfg(4).Tsim = 25;
cfg(4).x0   = [0.0; 0.0; pi + deg2rad(8); 0.0];

cfg(4).d_true   = 0.25;
cfg(4).sigma_v  = [1e-3; 2.5e-3; 1e-3; 2.5e-3];
cfg(4).obsPoles = [0.50 0.55 0.60 0.65 0.95];


%Set 5
cfg(5).name = 'Set 5';
cfg(5).Ts   = 0.05;
cfg(5).Aref = 0.25;
cfg(5).fref = 0.05;
cfg(5).duty = 50;
cfg(5).xref_offset = 0.0;

cfg(5).N = 50;
cfg(5).Q = diag([5, 1, 20, 1]);
cfg(5).R = 0.0001;
cfg(5).Rdu = 0.5;

cfg(5).x_max_cart      = 0.5;
cfg(5).x_max_cartdot   = 2.0;
cfg(5).x_max_theta_err = deg2rad(10);
cfg(5).x_max_thetadot  = deg2rad(120);
cfg(5).u_max = 5;

cfg(5).xf_max_cart      = 0.05;
cfg(5).xf_max_cartdot   = 0.15;
cfg(5).xf_max_theta_err = deg2rad(2);
cfg(5).xf_max_thetadot  = deg2rad(20);

cfg(5).Tsim = 25;
cfg(5).x0   = [0.0; 0.0; pi + deg2rad(8); 0.0];

cfg(5).d_true   = 0.25;
cfg(5).sigma_v  = [1e-3; 2.5e-3; 1e-3; 2.5e-3];
cfg(5).obsPoles = [0.50 0.55 0.60 0.65 0.97];

%% RunMode selector
switch lower(runMode)
    case 'set1'
        idxRun = 1;
    case 'set2'
        idxRun = 2;
    case 'set12'
        idxRun = [1 2];
    case 'lqr'
        idxRun = 3;
    case 'set1lqr'
        idxRun = [1 3];
    case 'set4'
        idxRun = 4;
    case 'set5'
        idxRun = 5;
    case 'set124'
        idxRun = [1 2 4];
    case 'set1245'
        idxRun = [1 2 4 5];
    otherwise
        error('runMode unknown.');
end

%% Running the cases
results = cell(numel(idxRun),1);
for ii = 1:numel(idxRun)
    if idxRun(ii) ~= 3
        if distnoise
            results{ii} = run_case_distnoise(cfg(idxRun(ii)), M, m, l, I, b, g);
        else
            results{ii} = run_case_reg(cfg(idxRun(ii)), M, m, l, I, b, g);
        end
    else
        results{ii} = run_lqr(cfg(idxRun(ii)), M, m, l, I, b, g);
    end
end

%% Plot disturbance estimate
if distnoise
    figure; hold on; grid on;
    for ii = 1:numel(results)
        res = results{ii};
        plot(res.thist, res.DhatHist, 'LineWidth', 1.6, ...
            'DisplayName', [res.name ' \hat d']);
    end
    yline(results{1}.cfg.d_true, '--k', 'DisplayName', 'd_{true}');
    xlabel('Time [s]'); ylabel('Disturbance estimate [N]');
    title('Constant disturbance estimate');
    legend('Location','best');
end

%% Overview Plots
figure('Name', 'Plots', 'Color', 'w');

subplot(3,1,1);
for ii = 1:numel(results)
    res = results{ii};
    plot(res.thist, res.Xhist(1,:), 'LineWidth', 1.5, ...
        'DisplayName', [res.name, ' x']); hold on;
end
plot(res.thist, res.Xrefhist(1,:), 'k--', 'LineWidth', 1.2, 'DisplayName','Reference');
grid on; ylabel('Cart Position [m]');
legend('Location','best');
title('Tracking Performance Comparison');

subplot(3,1,2);
for ii = 1:numel(results)
    res = results{ii};
    plot(res.thist, rad2deg(res.Xhist(3,:) - pi), 'LineWidth', 1.5, ...
        'DisplayName', [res.name, ' \theta-\pi']); hold on;
end
yline(rad2deg(cfg(3).x_max_theta_err), 'k--', 'LineWidth', 1, 'DisplayName', 'Constraints');
yline(-rad2deg(cfg(3).x_max_theta_err), 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
legend('Location','best');
grid on; ylabel('\theta-\pi [deg]');

subplot(3,1,3);
for ii = 1:numel(results)
    res = results{ii};
    stairs(res.thist(1:end-1), res.Uhist(1,:), 'LineWidth', 1.5, ...
        'DisplayName', [res.name, ' u']); hold on;
end
% yline(cfg(3).u_max, 'k--', 'LineWidth', 1, 'DisplayName', 'Constraints');
% yline(-cfg(3).u_max, 'k--', 'LineWidth', 1, 'HandleVisibility', 'off');
legend('Location','best');
grid on; ylabel('Force [N]'); xlabel('Time [s]');

%% Plot X_f projections
if xfprojplot
    if ~isempty(results) && isfield(results{1}, 'Xf')
        for ii = 1:numel(results)
            plot_terminal_set_all_projections(results{ii}.Xf, results{ii}.cfg, ...
                ['Terminal Set Projections - ' results{ii}.name]);
        end
    end
end

%% Compute and plot viability slice
if computeROA
    nStepsCheck = 50;

    for ii = 1:numel(results)
        if idxRun(ii) < 3
            sliceData = compute_closed_loop_viability_slice_reg_adaptive( ...
                cfg(1), M, m, l, I, b, g, 50, ...
                'MaxDepth', 10, ...
                'MinCellWidth', 0.001, ...
                'MinCellHeight', deg2rad(0.01), ...
                'UseCenterTest', true, ...
                'Verbose', true);
           
            plot_closed_loop_viability_slice_adaptive(sliceData, ...
                sprintf('Closed-loop viability slice - %s', cfg(1).name), ...
                'ShowCellEdges', false, ...
                'ShowMixedCells', false);
        end
    end
end


%% Animate
if doAnimation
    if numel(results) >= 2
        animate_two_pendulums_inverted(results{1}.thist, results{1}.Xhist, ...
                                       results{2}.thist, results{2}.Xhist, l, ...
                                       'PlaybackSpeed', 10.0, ...
                                       'ShowTrace', true, ...
                                       'TransparentCart', 1, ...
                                       'TransparentAlpha', 0.30, ...
                                       'Cart1Label', results{1}.name, ...
                                       'Cart2Label', results{2}.name);
    else
        animate_pendulum_inverted(results{1}.thist, results{1}.Xhist, l, ...
            'PlaybackSpeed', 10.0, 'ShowTrace', true);
    end
end

%% Functions
function res = run_case_distnoise(cfg, M, m, l, I, b, g)

    x_eq = [0; 0; pi; 0];
    u_eq = 0;

    [A_c, B_c, c_c] = linearize_dynamics_affine(x_eq, u_eq, M, m, l, I, b, g);
    [A, B, c] = discretize_affine(A_c, B_c, c_c, cfg.Ts);

    nx = size(A,1);
    nu = size(B,2);

    C  = eye(nx);
    p  = nx;
    
    nd = 1;
    Bd = B;
    Cd = zeros(p, nd);

    Aaug = [A, Bd;
            zeros(nd,nx), eye(nd)];
    Baug = [B;
            zeros(nd,nu)];
    Caug = [C, Cd];
    caug = [c;
            zeros(nd,1)];

    if rank(ctrb(A,B)) == size(A,1)
        disp('Controllability matrix is full rank, thus the system is controllable')
    end

    if rank(obsv(Aaug, Caug))== size(Aaug,1)
        disp('Observability matrix of augmented system is full rank, thus the augmented system is observable')
    end

    L = place(Aaug', Caug', cfg.obsPoles)';

    Tref = 1/cfg.fref;
    xref_fun    = @(t) pwm_reference(t, cfg.Aref, Tref, cfg.duty, cfg.xref_offset);

    xref_full = @(t) [xref_fun(t);
                      0;
                      pi;
                      0];

    Q   = cfg.Q;
    R   = cfg.R;
    Rdu = cfg.Rdu;
    N   = cfg.N;
    [~, P, ~] = dlqr(A, B, Q, R);

    if P == P'
        if min(eig(P))>0
            fprintf('Lowest eigenvalue of P is %s, and P is symmetric, thus P is positive definite \n', min(eig(P)))
        end
    end

    Xf = compute_terminal_invariant_set(A, B, Q, R, cfg);

    xmin = [-cfg.x_max_cart;
            -cfg.x_max_cartdot;
             pi - cfg.x_max_theta_err;
            -cfg.x_max_thetadot];

    xmax = [ cfg.x_max_cart;
              cfg.x_max_cartdot;
              pi + cfg.x_max_theta_err;
              cfg.x_max_thetadot];

    umin = -cfg.u_max;
    umax =  cfg.u_max;

    x0par    = sdpvar(nx,1);
    dhatpar  = sdpvar(nd,1);
    Xrvec    = sdpvar(nx*(N+1),1);
    Urefvec  = sdpvar(nu*N,1);
    uprevpar = sdpvar(nu,1);

    X = sdpvar(nx, N+1);
    U = sdpvar(nu, N);

    constraints = [X(:,1) == x0par];
    objective = 0;

    for k = 1:N
        xrk = Xrvec((k-1)*nx+1:k*nx);
        urk = Urefvec((k-1)*nu+1:k*nu);

        constraints = [constraints, X(:,k+1) == A*X(:,k) + B*U(:,k) + Bd*dhatpar + c];
        constraints = [constraints, xmin <= X(:,k) <= xmax];
        constraints = [constraints, umin <= U(:,k) <= umax];

        ex = X(:,k) - xrk;
        eu = U(:,k) - urk;

        if k == 1
            du = U(:,k) - uprevpar;
        else
            du = U(:,k) - U(:,k-1);
        end

        objective = objective + ex'*Q*ex + eu'*R*eu + du'*Rdu*du;
    end

    xrN = Xrvec(N*nx+1:(N+1)*nx);
    constraints = [constraints, Xf.A * (X(:,N+1) - xrN) <= Xf.b];

    eN = X(:,N+1) - xrN;
    objective = objective + eN'*P*eN;

    opts = sdpsettings('solver','quadprog','verbose',0);
    controller = optimizer(constraints, objective, opts, ...
        {x0par, dhatpar, Xrvec, Urefvec, uprevpar}, U(:,1));

    nsim  = round(cfg.Tsim/cfg.Ts);
    thist = (0:nsim)*cfg.Ts;

    x = cfg.x0;
    y = x + cfg.sigma_v .* randn(nx,1);
    zhat = [y; 0];
    u_prev = 0;

    Xhist    = zeros(nx, nsim+1);
    XhatHist = zeros(nx, nsim+1);
    Uhist    = zeros(nu, nsim);
    Xrefhist = zeros(nx, nsim+1);
    DhatHist = zeros(1, nsim+1);

    Xhist(:,1)    = x;
    XhatHist(:,1) = zhat(1:nx);
    Xrefhist(:,1) = xref_full(0);
    DhatHist(1)   = zhat(end);

    for k = 1:nsim
        tnow = thist(k);

        zhat = Aaug*zhat + Baug*u_prev + caug + L*(y - Caug*zhat);
        xhat = zhat(1:nx);
        dhat = zhat(end);

        xhat(3) = wrap_to_pi_branch(xhat(3), pi);
        zhat(3) = xhat(3);

        Xrnum = zeros(nx*(N+1),1);
        Urefnum = zeros(nu*N,1);

        for j = 0:N
            tj = tnow + j*cfg.Ts;
            xrefj = xref_full(tj);
            [xrj, urj] = steady_target_selector(A, B, c, Bd, dhat, xrefj);

            Xrnum(j*nx+1:(j+1)*nx) = xrj;
            if j < N
                Urefnum(j*nu+1:(j+1)*nu) = urj;
            end
        end

        u = controller{{xhat, dhat, Xrnum, Urefnum, u_prev}};
        if isempty(u)
            warning('%s: MPC infeasible at step %d. Applying previous input.', cfg.name, k);
            u = u_prev;
        end

        Uhist(:,k) = u;

        u_plant = u + cfg.d_true;
        [~, xsol] = ode45(@(t,xx) pendulum_nonlinear_inverted(xx, u_plant, M, m, l, I, b, g), ...
                          [0 cfg.Ts], x);
        x = xsol(end,:)';
        x(3) = wrap_to_pi_branch(x(3), pi);

        y = x + cfg.sigma_v .* randn(nx,1);

        Xhist(:,k+1)    = x;
        XhatHist(:,k+1) = xhat;
        Xrefhist(:,k+1) = xref_full(thist(k+1));
        DhatHist(k+1)   = dhat;

        u_prev = u;
    end

    res.name     = cfg.name;
    res.cfg      = cfg;
    res.thist    = thist;
    res.Xhist    = Xhist;
    res.XhatHist = XhatHist;
    res.Xrefhist = Xrefhist;
    res.Uhist    = Uhist;
    res.DhatHist = DhatHist;
    res.Xf       = Xf;
end

function res = run_case_reg(cfg, M, m, l, I, b, g)

    % Upright equilibrium
    x_eq = [0; 0; pi; 0];
    u_eq = 0;

    % Linearize and discretize
    [A_c, B_c, c_c] = linearize_dynamics_affine(x_eq, u_eq, M, m, l, I, b, g);
    [A, B, c] = discretize_affine(A_c, B_c, c_c, cfg.Ts);
    
    if rank(ctrb(A,B)) == size(A,1)
        disp('Controllability matrix is full rank, thus the system is controllable')
    end

    if rank(obsv(A, eye(4)))== size(A,1)
        disp('Observability matrix is full rank, thus the system is observable')
    end

    nx = size(A,1);
    nu = size(B,2);

    % Reference
    Tref = 1/cfg.fref;
    xref_fun    = @(t) pwm_reference(t, cfg.Aref, Tref, cfg.duty, cfg.xref_offset);

    r_fun = @(t) [xref_fun(t);
                  0;
                  pi;
                  0];

    % MPC data
    Q = cfg.Q;
    R = cfg.R;
    N = cfg.N;
    [~, P, ~] = dlqr(A, B, Q, R);

    if P == P'
        if min(eig(P))>0
            fprintf('Lowest eigenvalue of P is %s, and P is symmetric, thus P is positive definite \n', min(eig(P)))
        end
    end
    % Terminal invariant set in error coordinates
    Xf = compute_terminal_invariant_set(A, B, Q, R, cfg);
    
    % State / input constraints
    xmin = [-cfg.x_max_cart;
            -cfg.x_max_cartdot;
             pi - cfg.x_max_theta_err;
            -cfg.x_max_thetadot];

    xmax = [ cfg.x_max_cart;
              cfg.x_max_cartdot;
              pi + cfg.x_max_theta_err;
              cfg.x_max_thetadot];

    umin = -cfg.u_max;
    umax =  cfg.u_max;

    % Build optimizer
    x0   = sdpvar(nx,1);
    Rvec = sdpvar(nx*(N+1),1);
    X    = sdpvar(nx,N+1);
    U    = sdpvar(nu,N);

    constraints = [X(:,1) == x0];
    objective   = 0;

    for k = 1:N
        rk = Rvec((k-1)*nx+1:k*nx);

        constraints = [constraints, X(:,k+1) == A*X(:,k) + B*U(:,k) + c];
        constraints = [constraints, xmin <= X(:,k) <= xmax];
        constraints = [constraints, umin <= U(:,k) <= umax];

        ek = X(:,k) - rk;
        objective = objective + ek'*Q*ek + U(:,k)'*R*U(:,k);
    end

    % Terminal constraint: error state in Xf
    rN = Rvec(N*nx+1:(N+1)*nx);
    constraints = [constraints, xmin <= X(:,N+1) <= xmax];
    constraints = [constraints, Xf.A * (X(:,N+1) - rN) <= Xf.b];

    eN = X(:,N+1) - rN;
    objective = objective + eN'*P*eN;

    opts = sdpsettings('solver','quadprog','verbose',0);
    controller = optimizer(constraints, objective, opts, {x0, Rvec}, U(:,1));

    
    % Simulation
    nsim  = round(cfg.Tsim/cfg.Ts);
    thist = (0:nsim)*cfg.Ts;

    x = cfg.x0;
    Xhist    = zeros(nx,nsim+1);
    Uhist    = zeros(nu,nsim);
    Xrefhist = zeros(nx,nsim+1);

    Xhist(:,1)    = x;
    Xrefhist(:,1) = r_fun(0);

    for k = 1:nsim
        tnow = thist(k);

        % Build reference sequence for this MPC step
        Rnum = zeros(nx*(N+1),1);
        for j = 0:N
            tj = tnow + j*cfg.Ts;
            rj = r_fun(tj);
            Rnum(j*nx+1:(j+1)*nx) = rj;
        end

        % Solve MPC
        u = controller{{x, Rnum}};

        Uhist(:,k) = u;

        % Nonlinear plant propagation
        [~, xsol] = ode45(@(t,xx) pendulum_nonlinear_inverted(xx,u,M,m,l,I,b,g), [0 cfg.Ts], x);
        x = xsol(end,:)';
        x(3) = wrap_to_pi_branch(x(3), pi);

        if any(~isfinite(x))
            error('%s: nonlinear simulation produced NaN/Inf at step %d.', cfg.name, k);
        end

        Xhist(:,k+1)    = x;
        Xrefhist(:,k+1) = r_fun(thist(k+1));
    end

    res.name     = cfg.name;
    res.cfg      = cfg;
    res.thist    = thist;
    res.Xhist    = Xhist;
    res.Uhist    = Uhist;
    res.Xrefhist = Xrefhist;
    res.Xf       = Xf;
end

function res = run_lqr(cfg, M, m, l, I, b, g)

    x_eq = [0; 0; pi; 0];
    u_eq = 0;

    [A_c, B_c, c_c] = linearize_dynamics_affine(x_eq, u_eq, M, m, l, I, b, g);

    nx = size(A_c,1);
    nu = size(B_c,2);
    nsim = round(cfg.Tsim/cfg.Ts);

    [A, B, c] = discretize_affine(A_c, B_c, c_c, cfg.Ts); %#ok<ASGLU>
    [K_lqr, ~, ~] = dlqr(A, B, cfg.Q, cfg.R);

    Tref = 1/cfg.fref;
    xref_fun = @(t) pwm_reference(t, cfg.Aref, Tref, cfg.duty, cfg.xref_offset);
    
    r_fun = @(t) [xref_fun(t);
                  0;
                  pi;
                  0];

    x_lqr = cfg.x0;
    umax = cfg.u_max;
    umin = -cfg.u_max;

    Xhist_lqr = zeros(nx, nsim+1);
    Uhist_lqr = zeros(nu, nsim);
    thist = (0:nsim)*cfg.Ts;
    Xrefhist = zeros(nx, nsim+1);

    Xhist_lqr(:,1) = x_lqr;

    for k = 1:nsim
        rk = r_fun(thist(k));
        Xrefhist(:,k) = rk;

        err = x_lqr - rk;
        err(3) = atan2(sin(x_lqr(3) - rk(3)), cos(x_lqr(3) - rk(3)));

        u_lqr = -K_lqr * err;
        u_lqr = max(min(u_lqr, umax), umin);
        Uhist_lqr(:,k) = u_lqr;

        [~,xsol] = ode45(@(t,xx) pendulum_nonlinear_inverted(xx,u_lqr,M,m,l,I,b,g), [0 cfg.Ts], x_lqr);
        x_lqr = xsol(end,:)';
        x_lqr(3) = wrap_to_pi_branch(x_lqr(3), pi);
        Xhist_lqr(:,k+1) = x_lqr;
    end

    Xrefhist(:,nsim+1) = r_fun(thist(nsim+1));

    res.name     = cfg.name;
    res.cfg      = cfg;
    res.thist    = thist;
    res.Xhist    = Xhist_lqr;
    res.Uhist    = Uhist_lqr;
    res.Xrefhist = Xrefhist;
end

function Xf = compute_terminal_invariant_set(A,B,Q,R,cfg,varargin)
    p = inputParser;
    addParameter(p,'MaxIter',200);
    addParameter(p,'Tol',1e-8);
    addParameter(p,'UseMPT',true);
    addParameter(p,'Verbose',true);
    parse(p,varargin{:});

    maxIter = p.Results.MaxIter;
    tol     = p.Results.Tol;
    useMPT  = p.Results.UseMPT;
    verbose = p.Results.Verbose;

    nx = size(A,1);

    % -------------------------------------------------------------
    % 1) LQR terminal controller
    % -------------------------------------------------------------
    [K,~,~] = dlqr(A,B,Q,R);
    Acl = A - B*K;

    % -------------------------------------------------------------
    % 2) Initial admissible set X0 = {e | H0 e <= h0}
    %    Same terminal bounds as in your current code
    % -------------------------------------------------------------
    eFmax = [cfg.xf_max_cart;
             cfg.xf_max_cartdot;
             cfg.xf_max_theta_err;
             cfg.xf_max_thetadot];

    % State bounds in error coordinates
    Hx = [ eye(nx);
          -eye(nx)];
    hx = [ eFmax;
           eFmax];

    % Input bounds under u = -K e
    % |u| <= umax  ->  -umax <= -K e <= umax
    HuK = [-K;
            K];
    hu  = [cfg.u_max;
           cfg.u_max];

    % Base constraint set X0
    H0 = [Hx; HuK];
    h0 = [hx; hu];

    % Current accumulated constraint description:
    %   Hcur e <= hcur
    Hcur = H0;
    hcur = h0;

    % linprog options
    opts = optimoptions('linprog', ...
        'Algorithm','dual-simplex', ...
        'Display','none');

    % -------------------------------------------------------------
    % 3) Tutorial-style iteration:
    %    append H0*Acl^t e <= h0 until all are redundant
    % -------------------------------------------------------------
    if verbose
        fprintf('Computing terminal invariant set (tutorial style)...\n');
    end

    for t = 1:maxIter
        Hnew = H0 * (Acl^t);
        hnew = h0;

        allRedundant = true;
        rowsToAdd = false(size(Hnew,1),1);

        for i = 1:size(Hnew,1)
            f = Hnew(i,:);

            % Solve:
            %   max f e
            %   s.t. Hcur e <= hcur
            %
            % linprog solves min c'*e, so maximize via min -f*e
            [~,fval,exitflag] = linprog(-f(:), Hcur, hcur, [], [], [], [], opts);

            if exitflag ~= 1
                error('linprog failed during redundancy check at iteration %d, row %d.', t, i);
            end

            maxVal = -fval;

            % If current set allows a value larger than hnew(i),
            % then this inequality is NOT redundant and must be added
            if maxVal > hnew(i) + tol
                allRedundant = false;
                rowsToAdd(i) = true;
            end
        end

        if verbose
            fprintf('Iteration %d: %d new inequalities added.\n', t, nnz(rowsToAdd));
        end

        if allRedundant
            if verbose
                fprintf('Terminal invariant set converged after %d iterations.\n', t-1);
            end
            break;
        end

        % Add only the nonredundant inequalities
        Hcur = [Hcur; Hnew(rowsToAdd,:)];
        hcur = [hcur; hnew(rowsToAdd)];

        % Optional cleanup using MPT if available
        if useMPT && exist('Polyhedron','class') == 8
            Ptmp = Polyhedron('A',Hcur,'b',hcur);
            Ptmp.minHRep();
            Hcur = Ptmp.A;
            hcur = Ptmp.b;
        end
    end

    if t == maxIter && ~allRedundant && verbose
        warning('Maximum number of iterations reached before convergence.');
    end

    % -------------------------------------------------------------
    % 4) Return result
    % -------------------------------------------------------------
    if useMPT && exist('Polyhedron','class') == 8
        Xf = Polyhedron('A',Hcur,'b',hcur);
        Xf.minHRep();

        if Xf.isEmptySet
            error('Computed terminal set is empty.');
        end

        % store extra info if you want easy access
        Xf.Data.K    = K;
        Xf.Data.Acl  = Acl;
        Xf.Data.H0   = H0;
        Xf.Data.h0   = h0;
        Xf.Data.nIter = min(t,maxIter);
    else
        Xf = struct();
        Xf.A = Hcur;
        Xf.b = hcur;
        Xf.K = K;
        Xf.Acl = Acl;
        Xf.H0 = H0;
        Xf.h0 = h0;
        Xf.nIter = min(t,maxIter);
    end
end
   
function sliceData = compute_closed_loop_viability_slice_reg_adaptive(cfg, M, m, l, I, b, g, nStepsCheck, varargin)
    if nargin < 8 || isempty(nStepsCheck)
        nStepsCheck = 40;
    end

    p = inputParser;
    addParameter(p, 'MaxDepth', 6);            % max quadtree depth
    addParameter(p, 'MinCellWidth',  0.01);    % [m]
    addParameter(p, 'MinCellHeight', deg2rad(0.25)); % [rad]
    addParameter(p, 'UseCenterTest', true);
    addParameter(p, 'Verbose', true);
    parse(p, varargin{:});

    optsAdaptive = p.Results;

    %MPC
    x_eq = [0; 0; pi; 0];
    u_eq = 0;

    [A_c, B_c, c_c] = linearize_dynamics_affine(x_eq, u_eq, M, m, l, I, b, g);
    [A, B, c] = discretize_affine(A_c, B_c, c_c, cfg.Ts);

    nx = size(A,1);
    nu = size(B,2);
    N  = cfg.N;

    Tref = 1/cfg.fref;
    xref_fun    = @(t) pwm_reference(t, cfg.Aref, Tref, cfg.duty, cfg.xref_offset);

    r_fun = @(t) [xref_fun(t);
                  0;
                  pi;
                  0];

    Q = cfg.Q;
    R = cfg.R;
    [~, P, ~] = dlqr(A, B, Q, R);

    %Xf in error coordinates
    Xf = compute_terminal_invariant_set(A, B, Q, R, cfg);

    xmin = [-cfg.x_max_cart;
            -cfg.x_max_cartdot;
             pi - cfg.x_max_theta_err;
            -cfg.x_max_thetadot];

    xmax = [ cfg.x_max_cart;
              cfg.x_max_cartdot;
              pi + cfg.x_max_theta_err;
              cfg.x_max_thetadot];

    umin = -cfg.u_max;
    umax =  cfg.u_max;

    x0par = sdpvar(nx,1);
    Rvec  = sdpvar(nx*(N+1),1);

    X = sdpvar(nx,N+1);
    U = sdpvar(nu,N);

    constraints = [X(:,1) == x0par];
    objective   = 0;

    for k = 1:N
        rk = Rvec((k-1)*nx+1:k*nx);

        constraints = [constraints, X(:,k+1) == A*X(:,k) + B*U(:,k) + c];
        constraints = [constraints, xmin <= X(:,k) <= xmax];
        constraints = [constraints, umin <= U(:,k) <= umax];

        ek = X(:,k) - rk;
        objective = objective + ek'*Q*ek + U(:,k)'*R*U(:,k);
    end

    rN = Rvec(N*nx+1:(N+1)*nx);
    constraints = [constraints, xmin <= X(:,N+1) <= xmax];
    constraints = [constraints, Xf.A * (X(:,N+1) - rN) <= Xf.b];

    eN = X(:,N+1) - rN;
    objective = objective + eN'*P*eN;

    yopts = sdpsettings('solver','quadprog','verbose',0);
    controller = optimizer(constraints, objective, yopts, {x0par, Rvec}, U(:,1));

    cache = containers.Map('KeyType','char','ValueType','any');
    xMin   = -cfg.x_max_cart;
    xMax   =  cfg.x_max_cart;
    thMin  = -cfg.x_max_theta_err;
    thMax  =  cfg.x_max_theta_err;

    if optsAdaptive.Verbose
        fprintf('Starting adaptive viability slice refinement...\n');
    end

    cells = refine_cell(xMin, xMax, thMin, thMax, 0);

    sliceData.cells         = cells;
    sliceData.cfg           = cfg;
    sliceData.nStepsCheck   = nStepsCheck;
    sliceData.Xf            = Xf;
    sliceData.domain        = [xMin, xMax, thMin, thMax];
    sliceData.MaxDepth      = optsAdaptive.MaxDepth;
    sliceData.MinCellWidth  = optsAdaptive.MinCellWidth;
    sliceData.MinCellHeight = optsAdaptive.MinCellHeight;
    sliceData.cacheCount    = cache.Count;

    if optsAdaptive.Verbose
        fprintf('Adaptive refinement complete. Final number of leaf cells: %d\n', numel(cells));
        fprintf('Unique point evaluations stored in cache: %d\n', cache.Count);
    end

    %Function to refine one cell
    function leafCells = refine_cell(xL, xR, thL, thR, depth)

        pts = [xL, thL;
               xR, thL;
               xL, thR;
               xR, thR];

        if optsAdaptive.UseCenterTest
            pts = [pts;
                   0.5*(xL+xR), 0.5*(thL+thR)];
        end

        labels = false(size(pts,1),1);
        reasons = zeros(size(pts,1),1);

        for q = 1:size(pts,1)
            [labels(q), reasons(q)] = test_point_viability(pts(q,1), pts(q,2));
        end

        isUniform = all(labels == labels(1));
        cellTooSmall = ((xR - xL) <= optsAdaptive.MinCellWidth) || ...
                       ((thR - thL) <= optsAdaptive.MinCellHeight);
        atMaxDepth = depth >= optsAdaptive.MaxDepth;

        if isUniform || cellTooSmall || atMaxDepth
            leafCells = {struct( ...
                'xL', xL, 'xR', xR, ...
                'thL', thL, 'thR', thR, ...
                'depth', depth, ...
                'label', majority_label(labels), ...
                'sampleLabels', labels, ...
                'sampleReasons', reasons)};
            return;
        end

        xM  = 0.5*(xL + xR);
        thM = 0.5*(thL + thR);

        c1 = refine_cell(xL, xM, thL, thM, depth+1);
        c2 = refine_cell(xM, xR, thL, thM, depth+1);
        c3 = refine_cell(xL, xM, thM, thR, depth+1);
        c4 = refine_cell(xM, xR, thM, thR, depth+1);

        leafCells = [c1, c2, c3, c4];
    end

    %Function to test viability at one point
    function [ok, failCode] = test_point_viability(x0val, thErrVal)

        key = sprintf('%.12g_%.12g', x0val, thErrVal);
        if isKey(cache, key)
            val = cache(key);
            ok = val(1);
            failCode = val(2);
            return;
        end

        x = [x0val;
             0;
             pi + thErrVal;
             0];

        ok = true;
        failCode = 0;

        for kk = 1:nStepsCheck
            tnow = (kk-1)*cfg.Ts;

            Rnum = zeros(nx*(N+1),1);
            for pp = 0:N
                tp = tnow + pp*cfg.Ts;
                rp = r_fun(tp);
                Rnum(pp*nx+1:(pp+1)*nx) = rp;
            end

            u = controller{{x, Rnum}};
            if isempty(u)
                ok = false;
                failCode = 1;   % QP infeasible
                break;
            end

            [~, xsol] = ode45(@(t,xx) pendulum_nonlinear_inverted(xx, u, M, m, l, I, b, g), ...
                              [0 cfg.Ts], x);
            x = xsol(end,:)';

            if any(~isfinite(x))
                ok = false;
                failCode = 2;   % NaN/Inf
                break;
            end

            x(3) = wrap_to_pi_branch(x(3), pi);

            if any(x < xmin) || any(x > xmax)
                ok = false;
                failCode = 3;   % hard state violation
                break;
            end
        end

        if ok
            r_end = r_fun(nStepsCheck*cfg.Ts);
            e_end = x - r_end;
            e_end(3) = wrap_to_pi_branch(e_end(3), 0);

            if any(Xf.A * e_end > Xf.b + 1e-8)
                ok = false;
                failCode = 4;   % not in terminal set
            end
        end

        cache(key) = [double(ok), double(failCode)];
    end

    %Function for majority label of leafed cells
    function lbl = majority_label(lbls)
        if sum(lbls) >= ceil(numel(lbls)/2)
            lbl = true;
        else
            lbl = false;
        end
    end
end

function plot_closed_loop_viability_slice_adaptive(sliceData, figName, varargin)
% Plot adaptive viability slice returned by
% compute_closed_loop_viability_slice_reg_adaptive

    p = inputParser;
    addParameter(p, 'ShowCellEdges', true);
    addParameter(p, 'ShowMixedCells', false);
    addParameter(p, 'LineWidth', 0.0001);
    parse(p, varargin{:});

    showCellEdges = p.Results.ShowCellEdges;
    showMixedCells = p.Results.ShowMixedCells;
    lw = p.Results.LineWidth;

    figure('Name', figName, 'Color', 'w');
    hold on; grid on;

    % draw adaptive cells
    for k = 1:numel(sliceData.cells)
        C = sliceData.cells{k};

        xPoly = [C.xL, C.xR, C.xR, C.xL];
        yPoly = rad2deg([C.thL, C.thL, C.thR, C.thR]);

        if C.label
            faceCol = [0.2 0.7 0.2];   % green
        else
            faceCol = [0.9 0.1 0.1];   % red
        end

        if showCellEdges
            edgeCol = [0 0 0];
        else
            edgeCol = 'none';
        end

        patch(xPoly, yPoly, faceCol, ...
            'EdgeColor', edgeCol, ...
            'LineWidth', lw, ...
            'FaceAlpha', 1.0, ...
            'HandleVisibility', 'off');

        if showMixedCells
            if ~(all(C.sampleLabels == C.sampleLabels(1)))
                plot(mean([C.xL C.xR]), rad2deg(mean([C.thL C.thR])), ...
                    'ko', 'MarkerSize', 3, 'HandleVisibility', 'off');
            end
        end
    end

    xline(-sliceData.cfg.x_max_cart, 'k--', 'HandleVisibility', 'off');
    xline( sliceData.cfg.x_max_cart, 'k--', 'HandleVisibility', 'off');
    yline(-rad2deg(sliceData.cfg.x_max_theta_err), 'k--', 'HandleVisibility', 'off');
    yline( rad2deg(sliceData.cfg.x_max_theta_err), 'k--', 'HandleVisibility', 'off');

    xlabel('x [m]');
    ylabel('\theta-\pi [deg]');
    title(sprintf('%s (adaptive, checked %d steps)', figName, sliceData.nStepsCheck));

    plot(nan, nan, 's', 'MarkerSize', 10, ...
        'MarkerFaceColor', [0.2 0.7 0.2], ...
        'MarkerEdgeColor', [0.2 0.7 0.2], ...
        'DisplayName', 'Closed-loop viable');

    plot(nan, nan, 's', 'MarkerSize', 10, ...
        'MarkerFaceColor', [0.9 0.1 0.1], ...
        'MarkerEdgeColor', [0.9 0.1 0.1], ...
        'DisplayName', 'Not viable');

    % legend('Location','best');
end

function plot_terminal_set_all_projections(Xf, cfg, figName)

    figure('Name', figName, 'Color', 'w');

    subplot(2,2,1);
    plot_terminal_set_projection_in_axes(gca, Xf, cfg, [1 3], '(x,\theta-\pi)');

    subplot(2,2,2);
    plot_terminal_set_projection_in_axes(gca, Xf, cfg, [1 2], '(x,\dot{x})');

    subplot(2,2,3);
    plot_terminal_set_projection_in_axes(gca, Xf, cfg, [3 4], '(\theta-\pi,\dot{\theta})');

    subplot(2,2,4);
    plot_terminal_set_projection_in_axes(gca, Xf, cfg, [1 4], '(x,\dot{\theta})');
end

function plot_terminal_set_projection_in_axes(ax, Xf, cfg, idx, plotTitle)

    axes(ax); 
    cla(ax);
    hold(ax, 'on');
    grid(ax, 'on');

    labels = {'x error [m]', 'xdot error [m/s]', ...
              '\theta-\pi [deg]', '\thetadot [deg/s]'};

    emax = [cfg.xf_max_cart;
            cfg.xf_max_cartdot;
            cfg.xf_max_theta_err;
            cfg.xf_max_thetadot];

    xlim_box = emax(idx(1));
    ylim_box = emax(idx(2));

    if idx(1) >= 3, xlim_box = rad2deg(xlim_box); end
    if idx(2) >= 3, ylim_box = rad2deg(ylim_box); end

    xline(ax,  xlim_box, 'k--', 'HandleVisibility', 'off');
    xline(ax, -xlim_box, 'k--', 'HandleVisibility', 'off');
    yline(ax,  ylim_box, 'k--', 'HandleVisibility', 'off');
    yline(ax, -ylim_box, 'k--', 'HandleVisibility', 'off');

    Xproj = projection(Xf, idx);
    Xproj.minVRep();

    if ~Xproj.isEmptySet && ~isempty(Xproj.V)
        V = Xproj.V;
        xplot = V(:,1);
        yplot = V(:,2);

        if idx(1) >= 3, xplot = rad2deg(xplot); end
        if idx(2) >= 3, yplot = rad2deg(yplot); end

        VV = uniquetol([xplot yplot], 1e-9, 'ByRows', true);

        if size(VV,1) >= 3
            k = convhull(VV(:,1), VV(:,2));
            patch(ax, VV(k,1), VV(k,2), [0 0.4470 0.7410], ...
                'FaceAlpha', 0.15, ...
                'EdgeColor', [0 0.4470 0.7410], ...
                'LineWidth', 1.8, ...
                'DisplayName', 'Invariant set');
        elseif size(VV,1) == 2
            plot(ax, VV(:,1), VV(:,2), 'b-', 'LineWidth', 1.8, ...
                'DisplayName', 'Invariant set');
        else
            plot(ax, VV(:,1), VV(:,2), 'bo', 'DisplayName', 'Invariant set');
        end
    end

    xlabel(ax, labels{idx(1)});
    ylabel(ax, labels{idx(2)});
    title(ax, plotTitle, 'Interpreter', 'tex');
    legend(ax, 'Location', 'best');
end

function [xr, ur] = steady_target_selector(A, B, c, Bd, dhat, xref)
    nx = size(A,1);
    nu = size(B,2);

    Mss = [eye(nx)-A, -B;
           eye(nx),    zeros(nx,nu)];

    rhs = [Bd*dhat + c;
           xref];

    sol = pinv(Mss) * rhs;
    xr = sol(1:nx);
    ur = sol(nx+1:end);

    xr(3) = wrap_to_pi_branch(xr(3), pi);
end

function dx = pendulum_nonlinear_inverted(x,u,M,m,l,I,b,g)
    xdot     = x(2);
    theta    = x(3);
    thetadot = x(4);

    D = (M+m)*(I+m*l^2) - m^2*l^2*cos(theta)^2;
    xddot = ((I+m*l^2)*(u - b*xdot + m*l*thetadot^2*sin(theta)) + m^2*g*l^2*sin(theta)*cos(theta)) / D;
    thetaddot = (-(M+m)*m*g*l*sin(theta) - m*l*cos(theta)*(u - b*xdot + m*l*thetadot^2*sin(theta))) / D;
    dx = [xdot; xddot; thetadot; thetaddot];
end

function [A, B, c] = linearize_dynamics_affine(xeq, ueq, M, m, l, I, b, g)
    nx = length(xeq);
    nu = 1;

    f0 = pendulum_nonlinear_inverted(xeq, ueq, M, m, l, I, b, g);

    epsx = 1e-6;
    epsu = 1e-6;

    A = zeros(nx,nx);
    for i = 1:nx
        dx = zeros(nx,1);
        dx(i) = epsx;
        fp = pendulum_nonlinear_inverted(xeq + dx, ueq, M, m, l, I, b, g);
        fm = pendulum_nonlinear_inverted(xeq - dx, ueq, M, m, l, I, b, g);
        A(:,i) = (fp - fm)/(2*epsx);
    end

    B = zeros(nx,nu);
    fp = pendulum_nonlinear_inverted(xeq, ueq + epsu, M, m, l, I, b, g);
    fm = pendulum_nonlinear_inverted(xeq, ueq - epsu, M, m, l, I, b, g);
    B(:,1) = (fp - fm)/(2*epsu);

    c = f0 - A*xeq - B*ueq;
end

function [Ad, Bd, cd] = discretize_affine(A, B, c, Ts)
    nx = size(A,1);
    nu = size(B,2);

    Aaug = [A, c; zeros(1,nx), 0];
    Baug = [B; zeros(1,nu)];
    sysc_aug = ss(Aaug, Baug, eye(nx+1), zeros(nx+1,nu));
    sysd_aug = c2d(sysc_aug, Ts, 'zoh'); %zoh explicitly enforced

    Ad_aug = sysd_aug.A;
    Bd_aug = sysd_aug.B;

    Ad = Ad_aug(1:nx, 1:nx);
    Bd = Bd_aug(1:nx, :);
    cd = Ad_aug(1:nx, nx+1);
end

function th = wrap_to_pi_branch(theta, center)
    th = center + atan2(sin(theta-center), cos(theta-center));
end

function y = pwm_reference(t, Aref, Tref, duty, xoffset)
    phase = mod(t, Tref);
    high_state = phase < (duty/100)*Tref;
    y = xoffset + Aref*(2*high_state - 1);
end

%% Functions for animation
function animate_pendulum_inverted(thist, Xhist, l, varargin)
    p = inputParser;
    addParameter(p, 'PlaybackSpeed', 1.0);
    addParameter(p, 'ShowTrace', true);
    addParameter(p, 'CartWidth', 0.3);
    addParameter(p, 'CartHeight', 0.18);
    addParameter(p, 'MassRadius', 0.05);
    parse(p, varargin{:});

    playbackSpeed = p.Results.PlaybackSpeed;
    showTrace     = p.Results.ShowTrace;
    cartW         = p.Results.CartWidth;
    cartH         = p.Results.CartHeight;
    massR         = p.Results.MassRadius;

    thist = thist(:)';
    xCart = Xhist(1,:);
    theta = Xhist(3,:);

    wheelR  = 0.035;
    pivotY  = cartH/2;
    groundY = -cartH/2 - wheelR;

    xTip = xCart + l*sin(theta);
    yTip = pivotY - l*cos(theta);

    xmin = min([xCart - cartW, xTip]) - 0.2;
    xmax = max([xCart + cartW, xTip]) + 0.2;
    ymin = min([-0.15, yTip - massR]) - 0.1;
    ymax = max([cartH + 0.1, yTip + massR]) + 0.1;

    figure('Color','w');
    hold on; grid on; axis equal;
    xlim([xmin xmax]);
    ylim([ymin ymax]);
    xlabel('x [m]');
    ylabel('y [m]');
    title('True inverted pendulum animation');

    plot([xmin xmax], [groundY groundY], 'k-', 'LineWidth', 1.5);

    cartPatch = rectangle('Position', [xCart(1)-cartW/2, -cartH/2, cartW, cartH], ...
        'Curvature', 0.05, 'FaceColor', [0.2 0.6 0.9], 'EdgeColor', 'k', 'LineWidth', 1.2);

    ang = linspace(0, 2*pi, 80);
    wheel1 = plot(xCart(1)-cartW/4 + wheelR*cos(ang), groundY + wheelR*sin(ang), 'k', 'LineWidth', 1.2);
    wheel2 = plot(xCart(1)+cartW/4 + wheelR*cos(ang), groundY + wheelR*sin(ang), 'k', 'LineWidth', 1.2);

    pivotPlot = plot(xCart(1), pivotY, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 5);
    rodPlot = plot([xCart(1), xTip(1)], [pivotY, yTip(1)], '-', 'LineWidth', 2.5);
    bobPlot = plot(xTip(1), yTip(1), 'o', 'MarkerSize', 16, ...
        'MarkerFaceColor', [0.85 0.2 0.2], 'MarkerEdgeColor', 'k');

    if showTrace
        tracePlot = plot(xTip(1), yTip(1), '--', 'LineWidth', 1.0);
    else
        tracePlot = [];
    end

    timeText = text(xmin + 0.03*(xmax-xmin), ymax - 0.08*(ymax-ymin), ...
        sprintf('t = %.2f s', thist(1)), 'FontSize', 11, 'FontWeight', 'bold');

    for k = 1:length(thist)
        xc = xCart(k);
        xt = xTip(k);
        yt = yTip(k);

        cartPatch.Position = [xc-cartW/2, -cartH/2, cartW, cartH];

        set(wheel1, 'XData', xc-cartW/4 + wheelR*cos(ang), 'YData', groundY + wheelR*sin(ang));
        set(wheel2, 'XData', xc+cartW/4 + wheelR*cos(ang), 'YData', groundY + wheelR*sin(ang));

        set(pivotPlot, 'XData', xc, 'YData', pivotY);
        set(rodPlot, 'XData', [xc xt], 'YData', [pivotY yt]);
        set(bobPlot, 'XData', xt, 'YData', yt);

        if showTrace
            set(tracePlot, 'XData', xTip(1:k), 'YData', yTip(1:k));
        end

        set(timeText, 'String', sprintf('t = %.2f s', thist(k)));
        drawnow;

        if k < length(thist)
            pause((thist(k+1)-thist(k))/playbackSpeed);
        end
    end
end

function animate_two_pendulums_inverted(thist1, Xhist1, thist2, Xhist2, l, varargin)
    p = inputParser;
    addParameter(p, 'PlaybackSpeed', 1.0);
    addParameter(p, 'ShowTrace', true);
    addParameter(p, 'CartWidth', 0.3);
    addParameter(p, 'CartHeight', 0.18);
    addParameter(p, 'MassRadius', 0.02);
    addParameter(p, 'TransparentCart', 1);
    addParameter(p, 'TransparentAlpha', 0.35);
    addParameter(p, 'Cart1Label', 'Blue cart');
    addParameter(p, 'Cart2Label', 'Red cart');
    parse(p, varargin{:});

    playbackSpeed   = p.Results.PlaybackSpeed;
    showTrace       = p.Results.ShowTrace;
    cartW           = p.Results.CartWidth;
    cartH           = p.Results.CartHeight;
    massR           = p.Results.MassRadius;
    transparentCart = p.Results.TransparentCart;
    alphaTrans      = p.Results.TransparentAlpha;
    cart1Label      = p.Results.Cart1Label;
    cart2Label      = p.Results.Cart2Label;

    if ~ismember(transparentCart, [1 2])
        error('TransparentCart must be 1 or 2.');
    end

    thist1 = thist1(:)';
    thist2 = thist2(:)';
    if length(thist1) ~= length(thist2) || any(abs(thist1 - thist2) > 1e-12)
        error('Both animations must use the same time vector.');
    end
    thist = thist1;

    xCart1 = Xhist1(1,:);
    theta1 = Xhist1(3,:);
    xCart2 = Xhist2(1,:);
    theta2 = Xhist2(3,:);

    wheelR  = 0.035;
    pivotY  = cartH/2;
    groundY = -cartH/2 - wheelR;
    rodHalfWidth = 0.005;

    xTip1 = xCart1 + l*sin(theta1);
    yTip1 = pivotY - l*cos(theta1);

    xTip2 = xCart2 + l*sin(theta2);
    yTip2 = pivotY - l*cos(theta2);

    xmin = min([xCart1 - cartW, xTip1, xCart2 - cartW, xTip2]) - 0.2;
    xmax = max([xCart1 + cartW, xTip1, xCart2 + cartW, xTip2]) + 0.2;
    ymin = min([-0.15, yTip1 - massR, yTip2 - massR]) - 0.1;
    ymax = max([cartH + 0.1, yTip1 + massR, yTip2 + massR]) + 0.1;

    figure('Color','w');
    hold on; grid on; axis equal;
    xlim([xmin xmax]);
    ylim([ymin ymax]);
    xlabel('x [m]');
    ylabel('y [m]');
    title('Two inverted pendulums animation');

    plot([xmin xmax], [groundY groundY], 'k-', 'LineWidth', 1.5, 'HandleVisibility', 'off');

    ang = linspace(0, 2*pi, 80);

    blueColor = [0.2 0.6 0.9];
    redColor  = [0.85 0.2 0.2];
    rodBlue   = [0 0.4470 0.7410];
    rodRed    = [0.8500 0.3250 0.0980];

    if transparentCart == 1
        alpha1 = alphaTrans;
        alpha2 = 1.0;
    else
        alpha1 = 1.0;
        alpha2 = alphaTrans;
    end

    [xb1, yb1] = cart_box(xCart1(1), cartW, cartH);
    cartPatch1 = patch(xb1, yb1, blueColor, 'EdgeColor', 'k', 'LineWidth', 1.2, ...
        'FaceAlpha', alpha1, 'EdgeAlpha', alpha1, 'DisplayName', cart1Label);

    wheel11 = patch(xCart1(1)-cartW/4 + wheelR*cos(ang), groundY + wheelR*sin(ang), [0 0 0], ...
        'FaceColor', 'none', 'EdgeColor', 'k', 'LineWidth', 1.2, 'EdgeAlpha', alpha1, 'HandleVisibility', 'off');
    wheel12 = patch(xCart1(1)+cartW/4 + wheelR*cos(ang), groundY + wheelR*sin(ang), [0 0 0], ...
        'FaceColor', 'none', 'EdgeColor', 'k', 'LineWidth', 1.2, 'EdgeAlpha', alpha1, 'HandleVisibility', 'off');

    [xrod1, yrod1] = rod_box(xCart1(1), pivotY, xTip1(1), yTip1(1), rodHalfWidth);
    rodPatch1 = patch(xrod1, yrod1, rodBlue, 'EdgeColor', 'none', 'FaceAlpha', alpha1, 'HandleVisibility', 'off');

    [xpiv1, ypiv1] = circle_patch(xCart1(1), pivotY, 0.008, 40);
    pivotPatch1 = patch(xpiv1, ypiv1, [0 0 0], 'EdgeColor', 'k', ...
        'FaceAlpha', alpha1, 'EdgeAlpha', alpha1, 'HandleVisibility', 'off');

    [xbob1, ybob1] = circle_patch(xTip1(1), yTip1(1), massR, 20);
    bobPatch1 = patch(xbob1, ybob1, blueColor, 'EdgeColor', 'k', 'LineWidth', 1.0, ...
        'FaceAlpha', alpha1, 'EdgeAlpha', alpha1, 'HandleVisibility', 'off');

    if showTrace
        tracePlot1 = plot(xTip1(1), yTip1(1), '--', 'Color', blueColor, 'LineWidth', 1.0, 'HandleVisibility', 'off');
    else
        tracePlot1 = [];
    end

    [xb2, yb2] = cart_box(xCart2(1), cartW, cartH);
    cartPatch2 = patch(xb2, yb2, redColor, 'EdgeColor', 'k', 'LineWidth', 1.2, ...
        'FaceAlpha', alpha2, 'EdgeAlpha', alpha2, 'DisplayName', cart2Label);

    wheel21 = patch(xCart2(1)-cartW/4 + wheelR*cos(ang), groundY + wheelR*sin(ang), [0 0 0], ...
        'FaceColor', 'none', 'EdgeColor', 'k', 'LineWidth', 1.2, 'EdgeAlpha', alpha2, 'HandleVisibility', 'off');
    wheel22 = patch(xCart2(1)+cartW/4 + wheelR*cos(ang), groundY + wheelR*sin(ang), [0 0 0], ...
        'FaceColor', 'none', 'EdgeColor', 'k', 'LineWidth', 1.2, 'EdgeAlpha', alpha2, 'HandleVisibility', 'off');

    [xrod2, yrod2] = rod_box(xCart2(1), pivotY, xTip2(1), yTip2(1), rodHalfWidth);
    rodPatch2 = patch(xrod2, yrod2, rodRed, 'EdgeColor', 'none', 'FaceAlpha', alpha2, 'HandleVisibility', 'off');

    [xpiv2, ypiv2] = circle_patch(xCart2(1), pivotY, 0.008, 40);
    pivotPatch2 = patch(xpiv2, ypiv2, [0 0 0], 'EdgeColor', 'k', ...
        'FaceAlpha', alpha2, 'EdgeAlpha', alpha2, 'HandleVisibility', 'off');

    [xbob2, ybob2] = circle_patch(xTip2(1), yTip2(1), massR, 20);
    bobPatch2 = patch(xbob2, ybob2, redColor, 'EdgeColor', 'k', 'LineWidth', 1.0, ...
        'FaceAlpha', alpha2, 'EdgeAlpha', alpha2, 'HandleVisibility', 'off');

    if showTrace
        tracePlot2 = plot(xTip2(1), yTip2(1), '--', 'Color', redColor, 'LineWidth', 1.0, 'HandleVisibility', 'off');
    else
        tracePlot2 = [];
    end

    if transparentCart == 1
        bring_cart_to_front(cartPatch1, wheel11, wheel12, pivotPatch1, rodPatch1, bobPatch1, tracePlot1, showTrace);
        send_cart_to_back(cartPatch2, wheel21, wheel22, pivotPatch2, rodPatch2, bobPatch2, tracePlot2, showTrace);
    else
        bring_cart_to_front(cartPatch2, wheel21, wheel22, pivotPatch2, rodPatch2, bobPatch2, tracePlot2, showTrace);
        send_cart_to_back(cartPatch1, wheel11, wheel12, pivotPatch1, rodPatch1, bobPatch1, tracePlot1, showTrace);
    end

    legend([cartPatch1, cartPatch2], 'Location', 'best');

    timeText = text(xmin + 0.03*(xmax-xmin), ymax - 0.08*(ymax-ymin), ...
        sprintf('t = %.2f s', thist(1)), 'FontSize', 11, 'FontWeight', 'bold');

    for k = 1:length(thist)
        xc1 = xCart1(k); xt1 = xTip1(k); yt1 = yTip1(k);
        [xb1, yb1] = cart_box(xc1, cartW, cartH);
        set(cartPatch1, 'XData', xb1, 'YData', yb1);
        set(wheel11, 'XData', xc1-cartW/4 + wheelR*cos(ang), 'YData', groundY + wheelR*sin(ang));
        set(wheel12, 'XData', xc1+cartW/4 + wheelR*cos(ang), 'YData', groundY + wheelR*sin(ang));
        [xrod1, yrod1] = rod_box(xc1, pivotY, xt1, yt1, rodHalfWidth);
        set(rodPatch1, 'XData', xrod1, 'YData', yrod1);
        [xpiv1, ypiv1] = circle_patch(xc1, pivotY, 0.018, 40);
        set(pivotPatch1, 'XData', xpiv1, 'YData', ypiv1);
        [xbob1, ybob1] = circle_patch(xt1, yt1, massR, 50);
        set(bobPatch1, 'XData', xbob1, 'YData', ybob1);
        if showTrace
            set(tracePlot1, 'XData', xTip1(1:k), 'YData', yTip1(1:k));
        end

        xc2 = xCart2(k); xt2 = xTip2(k); yt2 = yTip2(k);
        [xb2, yb2] = cart_box(xc2, cartW, cartH);
        set(cartPatch2, 'XData', xb2, 'YData', yb2);
        set(wheel21, 'XData', xc2-cartW/4 + wheelR*cos(ang), 'YData', groundY + wheelR*sin(ang));
        set(wheel22, 'XData', xc2+cartW/4 + wheelR*cos(ang), 'YData', groundY + wheelR*sin(ang));
        [xrod2, yrod2] = rod_box(xc2, pivotY, xt2, yt2, rodHalfWidth);
        set(rodPatch2, 'XData', xrod2, 'YData', yrod2);
        [xpiv2, ypiv2] = circle_patch(xc2, pivotY, 0.018, 40);
        set(pivotPatch2, 'XData', xpiv2, 'YData', ypiv2);
        [xbob2, ybob2] = circle_patch(xt2, yt2, massR, 50);
        set(bobPatch2, 'XData', xbob2, 'YData', ybob2);
        if showTrace
            set(tracePlot2, 'XData', xTip2(1:k), 'YData', yTip2(1:k));
        end

        if transparentCart == 1
            bring_cart_to_front(cartPatch1, wheel11, wheel12, pivotPatch1, rodPatch1, bobPatch1, tracePlot1, showTrace);
        else
            bring_cart_to_front(cartPatch2, wheel21, wheel22, pivotPatch2, rodPatch2, bobPatch2, tracePlot2, showTrace);
        end

        set(timeText, 'String', sprintf('t = %.2f s', thist(k)));
        drawnow;

        if k < length(thist)
            pause((thist(k+1)-thist(k))/playbackSpeed);
        end
    end
end

function [xv, yv] = cart_box(xc, cartW, cartH)
    xv = [xc-cartW/2, xc+cartW/2, xc+cartW/2, xc-cartW/2];
    yv = [-cartH/2, -cartH/2, cartH/2, cartH/2];
end

function [xc, yc] = circle_patch(x0, y0, r, n)
    ang = linspace(0, 2*pi, n);
    xc = x0 + r*cos(ang);
    yc = y0 + r*sin(ang);
end

function [xr, yr] = rod_box(x1, y1, x2, y2, halfWidth)
    dx = x2 - x1;
    dy = y2 - y1;
    L = hypot(dx, dy);

    if L < 1e-12
        xr = [x1 x1 x1 x1];
        yr = [y1 y1 y1 y1];
        return;
    end

    nx = -dy / L;
    ny =  dx / L;

    xr = [x1 + halfWidth*nx, ...
          x1 - halfWidth*nx, ...
          x2 - halfWidth*nx, ...
          x2 + halfWidth*nx];

    yr = [y1 + halfWidth*ny, ...
          y1 - halfWidth*ny, ...
          y2 - halfWidth*ny, ...
          y2 + halfWidth*ny];
end

function bring_cart_to_front(cartPatch, wheel1, wheel2, pivotPatch, rodPatch, bobPatch, tracePlot, showTrace)
    uistack(cartPatch, 'top');
    uistack(wheel1, 'top');
    uistack(wheel2, 'top');
    uistack(pivotPatch, 'top');
    uistack(rodPatch, 'top');
    uistack(bobPatch, 'top');
    if showTrace && ~isempty(tracePlot)
        uistack(tracePlot, 'top');
    end
end

function send_cart_to_back(cartPatch, wheel1, wheel2, pivotPatch, rodPatch, bobPatch, tracePlot, showTrace)
    if showTrace && ~isempty(tracePlot)
        uistack(tracePlot, 'bottom');
    end
    uistack(bobPatch, 'bottom');
    uistack(rodPatch, 'bottom');
    uistack(pivotPatch, 'bottom');
    uistack(wheel2, 'bottom');
    uistack(wheel1, 'bottom');
    uistack(cartPatch, 'bottom');
end
