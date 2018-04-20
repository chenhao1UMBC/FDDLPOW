
% all the codes show projection for L =2
cname = {'BLE', 'BT', 'FHSS1', 'FHSS2', 'Wi-Fi1', 'Wi-Fi2'};
symb = {'x','sq', '*', '>','^','.'};
for ii = 1:6
rt(ii, :) = H(:,ii)'*W'*aoos(Z,4,size(Z, 2))/norm(H(:, ii),2);
plot(rt(ii, 1:end/2), symb{ii}); grid on; hold on
end
legend(cname)

figure
pr = rt(:, [251:300,1001:1050]);
[~, lb] = sort(pr, 1, 'descend');
imagesc(pr)


NComb = combnk(1:6, 2);
X = cell(6, 1);
Xt = cell(size(NComb,1),1);
for ii = 1:6
    X{ii} = Database.tr_data(:, 1+ 1200*(ii-1):1200*ii);    
end

for ii = 1: size(NComb, 1)    
    figure
    Xt{ii} = Database.test_mixdata(:, 1+ 200*(ii-1):200*ii);
    imagesc(Xt{ii})
    title(['testing of ',cname{NComb(ii,1)},' and ', cname{NComb(ii,2)} ]);
    colorbar
    
    figure; 
    imagesc(X{NComb(ii,1)}(:, 1:200)+ X{NComb(ii, 2)}(:, 1:200));
    title(['sum of ',cname{NComb(ii,1)},' and ', cname{NComb(ii,2)} ]);
    colorbar
end

figure
imagesc(Dict_mix.D); title 'Dictionary'; colorbar

Zs = aoos(Z,4,size(Z, 2));
tr_Zs = aoos(Dict_mix.Z,4,size(Dict_mix.Z, 2));
figure; imagesc([W'*Zs(:, [251:300,1001:1050]), W'*tr_Zs(:, [301:900, 1501:1800])])

ZZ = cell(6, 1);
for ii = 1:6
    ZZ{ii} = tr_Zs(:, 1+ 300*(ii-1):300*ii);
end
[bt, ind2] = sort(abs(sum(ZZ{2}, 2)), 'descend');
[fhss1, ind3] = sort(abs(sum(ZZ{3}, 2)), 'descend');
[wifi2, ind6] = sort(abs(sum(ZZ{6}, 2)), 'descend');
figure
imagesc(Dict_mix.D(:, ind2(1:18)));
title 'atoms used for BT'
figure
imagesc(Dict_mix.D(:, ind3(1:18)));
title 'atoms used for FHSS1'
figure
imagesc(Dict_mix.D(:, ind6(1:18)));
title 'atoms used for Wifi2'

figure 
imagesc([Dict_mix.D(:, ind2(1:18)), Dict_mix.D(:, ind3(1:18)),Dict_mix.D(:, ind6(1:18)) ]);
hold on
line([18, 18],[1,1000],'color','r')
line([36, 36],[1,1000],'color','r')
title 'atoms used for BT, FHSS1 and Wifi2'


Z_weak2_3 = Zs(:, 251:300); % equal power case Z_weak2_3 == Z_2_weak3
Z_2_weak3 = Zs(:, 1001:1050);

figure; imagesc(ZZ{2}); title 'bt'; colorbar
figure; imagesc(ZZ{3}); title 'FHSS1'; colorbar
figure; imagesc(ZZ{6}); title 'wifi2'; colorbar
figure; imagesc(Z_weak2_3); title 'test bt + FHSS1'; colorbar
% figure; imagesc(Z_weak2_3); title 'weak bt + FHSS1'; colorbar
% figure; imagesc(Z_2_weak3); title 'bt + weak FHSS1'; colorbar
close all

figure; imagesc(W'*ZZ{2}); title 'bt'; colorbar
figure; imagesc(W'*ZZ{3}); title 'FHSS1'; colorbar
figure; imagesc(W'*ZZ{6}); title 'wifi2'; colorbar
figure; imagesc(W'*Z_weak2_3); title 'test bt + FHSS1'; colorbar
% figure; imagesc(W'*Z_weak2_3); title 'weak bt + FHSS1'; colorbar
% figure; imagesc(W'*Z_2_weak3); title 'bt + weak FHSS1'; colorbar
figure; imagesc(W'*(ZZ{2} + ZZ{3})); title 'bt + FHSS1'; colorbar
figure; imagesc(W'*(ZZ{2} + ZZ{6})); title 'bt + wifi2'; colorbar
close all

Z0 = (3.16*ZZ{2}+ZZ{3});
result0 = pinv(H)*W'*aoos(Z0,4,size(Z0, 2));
[~, labels_pre0] = sort(result0, 1, 'descend');

Z0 = (10* ZZ{2}+ZZ{3});
result0 = pinv(H)*W'*aoos(Z0,4,size(Z0, 2));
[~, labels_pre0] = sort(result0, 1, 'descend');
