function [LncfunSim]=func_Sim(ID_dis_lncR,nl,disSemSim)
LncfunSim=zeros(nl,nl);
    for i=1:nl
        for j=1:nl
            if i==j
                LncfunSim(i,j)=1;
            else
                d1=find(ID_dis_lncR(:,i));
                d2=find(ID_dis_lncR(:,j));
                if  length(d1)==0|length(d2)==0
                    continue;
                end
                t1=0;
                t2=0;
                for k=1:length(d1)
                    t1=t1+max(disSemSim(d1(k),d2));
                end
                for k=1:length(d2)
                    t2=t2+max(disSemSim(d2(k),d1));
                end
                LncfunSim(i,j)=(t1+t2)/(length(d1)+length(d2));
            end  
        end
    end
end