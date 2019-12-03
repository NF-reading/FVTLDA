function outputdata = RefluxLD(interaction,l_lsimi,k1,k2,r)
load('new_disSemSim');
for i=1:length(interaction(:,1))
    l_re=find(interaction(i,:)>0);
    for j=1:length(interaction(1,:))
        d_clique=find(new_disSemSim(j,:)>0);
        real=intersect(l_re,d_clique);
        sum=0;
        if ~isempty(real)
             for x=1:length(real)
                    sum=sum+new_disSemSim(j,real(x));
             end
            if interaction(i,j)>0
                output2(i,j)=1+(sum-1)*k1;
            else
                output2(i,j)=sum*k1;
            end
        else
            output2(i,j)=0;
        end    
    end
end

for i=1:length(interaction(1,:))
    d_re=find(interaction(:,i)>0);
    for j=1:length(interaction(:,1))
        l_clique=find(l_lsimi(j,:)>0);
        real=intersect(d_re,l_clique);
        sum=0;
        if ~isempty(real)
             for x=1:length(real)
                    sum=sum+l_lsimi(j,real(x));
             end
            if interaction(j,i)>0
                output1(j,i)=1+(sum-1)*k2;
            else
                output1(j,i)=sum*k2;
            end
        else
            output1(j,i)=0;
        end    
    end
end
output=r*output1+(1-r)*output2;
ls = 1;
for j=1:length(interaction(1,:))
    for i = 1:length(interaction(:,1))
        outputdata(1,ls)=output(i,j);
        ls=ls+1;
    end
end
        
