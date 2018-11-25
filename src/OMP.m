function  x = OMP(A, y)
    
    xini = zeros(size(A,2),1);
    basis = [];
    residue = y;
    prev_residue = y + 2*(ones(size(y)));
    xans = [];
    count = 0;
    
    % Change the termination condition set eta
    eta = 0.000001;
    while ((count<200) && (sum(abs(prev_residue - residue) >= eta*ones(size(y))) > 0))
        disp("Iteration " + count); 
        % Finding out the projections on residue
        proj = abs(A' * residue);
        [~, index] = max(proj);
        
        % Updating the basis
        basis = [basis index];

        % Finding out new x
        inv = A(:, basis);
        inv = (inv' * inv)\(inv'*y);
        xans = inv;
        
        % Updating the residue
        prev_residue = residue;
        residue = y - (A(:,basis) * xans);
        count = count + 1;
    end

    x = xini;
    t = basis';
    x(t) = xans;

end
