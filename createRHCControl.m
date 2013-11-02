function out = createRHCControl(cost_gen, constr_gen, env)

  A = env.A;
  B = env.B;
  N = env.N;

  function u0 = RHC(x0)

    %% Create sdpvars as cell arrays for uniformity in coding.
    x = {};

    for k = 1:N
      x = [x; {sdpvar(size(A,2),1)}];
    end

    u = {};
    for k = 1:N
      u = [u; {sdpvar(size(B,2),1)}];
    end

    %% Make sure to provide env with everything you need!
    constr = constr_gen(x0, x, u, env);
    cost  = cost_gen(x0, x, u, env);

    %% Solve the RHC
    evalc('solvesdp(constr, cost);');

    u0 = double(u{1});

  end

  out = @RHC;

end
