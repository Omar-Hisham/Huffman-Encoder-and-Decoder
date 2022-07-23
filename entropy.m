function entrop = entropy(keyset,data)
%% calculate the entropy which is the summ of prob*log2(1/prob)....
P=[];
entrop=0;
for i = 1:length(keyset)
P=[P count(data,keyset(i))/length(data)];
e=P(i)*log2(1/P(i)); % calculating entropy of this character...
entrop = entrop+e;% add entropy of this character to the previous characters...
end
end