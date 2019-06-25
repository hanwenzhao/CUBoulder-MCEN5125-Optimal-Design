function xxx = xhat(mu)
    x_cor = HW2Prob3;
    D = sparse(999,1000);
    D(:,1:999) =  -speye(999);
    D(:,2:1000) =  D(:,2:1000) + speye(999);
    xxx = (speye(1000) + mu*D'*D) \ x_cor;
end