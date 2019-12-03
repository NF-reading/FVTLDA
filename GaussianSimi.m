function [kl] = GaussianSimi(interaction)
nl = length(interaction(:,1));
gamal = nl/(norm(interaction,'fro')^2);
kl = zeros(nl,nl);
E = interaction*interaction';
for i=1:nl
    for j=i:nl
        kl(i,j)=exp(-gamal*(E(i,i)+E(j,j)-2*E(i,j)));
    end
end
kl = kl+kl'-diag(diag(kl));
