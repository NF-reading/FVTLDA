function [input] = SumnormalM(input,num)
if(num==1)
    suinput = sum(input,2);
    for i=1:length(input(:,1))
        input(i,:)=input(i,:)/suinput(i);
    end
else
    suinput = sum(input);
    for i=1:length(input(1,:))
        input(:,i)=input(:,i)/suinput(i);
    end
end
end