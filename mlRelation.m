function [normml] = mlRelation(normkm,normml,r)
normml1 = normml;
normmlpro = normml;
normml=(1-r)*normkm*normmlpro+r*normml1;
 while(norm(normmlpro-normml)>1*10^-10)
         normmlpro = normml;
         normml =(1-r)*normkm'*normmlpro+r*normml1;
 end
end