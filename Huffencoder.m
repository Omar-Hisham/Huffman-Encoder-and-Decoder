function [codeword, indices,P] = Huffencoder(P,keyset)
%% Encoding...
codeword = cell(length(P), 1); % codewords are represent as numerical vectors for bits
[P, indices] = sort(P, 'descend');%% sort the probabilties which is the first step of encoding
symbols = struct('probability', num2cell(P), 'indices', num2cell(indices));%% put the sorted prob and the original indeices if them in struct ....
while length(symbols) > 1
    preLast = symbols(end-1); %%define the prelast prob..
    last = symbols(end); %% define the last prob..
    %%Build the code words by prepending bits -- define the prelast prob by zero and last prob by one....
    codeword(preLast.indices) = cellfun(@(x)[0 x], codeword(preLast.indices), 'UniformOutput', false);
    codeword(last.indices) = cellfun(@(x)[1 x], codeword(last.indices), 'UniformOutput', false);
%%Adding the last 2 probabilties....
    probSum = last.probability + preLast.probability;
    %%define a struct that contain the sum and the indeices of the 2 prob that are summed...
    newSymbol = struct('probability', probSum, 'indices', [last.indices preLast.indices]);
    pos = find([symbols.probability] <= probSum, 1);%% compareing between this sum and all rest items to know where to put it (the sum is put above  less than or equal number)
    %%put the sum in its position above the less than or equal prob to it and below the greater prob. 
    symbols = [symbols(1:pos-1) newSymbol symbols(pos:end-2)];
end
disp('Table for each character and its codeword')
fileID = fopen('encoding.txt','w');
fprintf(fileID,'%-10s%-10s\r\n','Keyset','codeword');
fprintf('%-10s%-10s\n','Keyset','codeword');
for i = 1:length(keyset)
     
    fprintf(fileID,'%-10s%d%d%d%d%d%d%d%d%d%d%d',keyset(i),cell2mat(codeword(i)));
    fprintf(fileID,'\r\n');
    fprintf('%-10s%d%d%d%d%d%d%d%d%d%d%d',keyset(i),cell2mat(codeword(i)));
    fprintf('\n');
  
end
fclose(fileID);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%