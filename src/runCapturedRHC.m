function [x, u] = runCapturedRHC(control, x0, A, B, num_steps)

  %% Create buffer functions to capture the x and u states as the loop
  %% progresses.
  tee_x = createTee();
  tee_u = createTee();

  xk = tee_x(x0);
  for k = 1 : num_steps
    uk = tee_u(control(xk));
    xk = tee_x(A*xk + B*uk);
  end

  %% Convert into arrays.
  [~, x_cells] = tee_x();
  [~, u_cells] = tee_u();

  x = horzcat(x_cells{:});
  u = horzcat(u_cells{:});

end
