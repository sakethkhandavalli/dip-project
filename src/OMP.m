function [x] = OMP (K,y,A)
    % return x which is the k-sparse representation of the signal y
    %% Initializations
    [m,n] = size (A) ;
    Q = zeros (m,K) ;
    R = zeros (K,K) ;
    Rinv = zeros (K,K) ;
    w = zeros (m,K) ;
    x = zeros (1,n) ;
    
    Res = y.' ; % Initialize residue to y
    for J = 1 : K    
        %Find the index of maximum projection component on residue
        [V ,kkk] = max(abs(A'*Res)) ;
        kk (J) = kkk ;
        
        %Update Residue using newly obtained basis
        w (:,J) = A (:,kk (J)) ;
        for I = 1 : J-1
            if (J-1 ~= 0)
                R (I,J) = Q (:,I)' * w (:,J) ;
                w (:,J) = w (:,J) - R (I,J) * Q (:,I) ;
            end
        end
        R (J,J) = norm (w (:,J)) ;
        Q (:,J) = w (:,J) / R (J,J) ;
        Res = Res - (Q (:,J) * Q (:,J)' * Res) ;
    end
    
    %Find x which minimizes the Least Squares error
    for J = 1 : K
        Rinv (J,J) = 1 / R (J,J) ;
        if (J-1 ~= 0)
            for I = 1 : J-1
                Rinv (I,J) = -Rinv (J,J) * (Rinv (I,1:J-1) * R (1:J-1,J)) ;
            end
        end
    end
    xx = Rinv * Q' * y.' ;
    for I = 1 : K
        x (kk (I)) = xx (I) ;
    end
end
