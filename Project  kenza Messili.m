%NOm:Messili
%Prenom:Kenza



% List of city names corresponding to the dataset lines
villes = {'Béthune', 'Le Havre', 'Rennes', 'Angers', 'Nantes', 'Limoges','Bordeaux', 'Bayonne', 'Pau', 'Toulouse', 'Nîmes', 'Valence','Lyon', 'Dijon', 'Paris', 'Reims', 'Metz', 'Annecy', 'Poitiers'};

%load the dataset of the market
Dataset=load('supermarche.txt');

%Display the dataset
disp('La base de donnees est  :');
disp(Dataset);

%Data size
disp('dimension de la base de donnees:');
disp(size(Dataset));

%Center the data
Data_centered=Dataset-mean(Dataset);
disp('La base de donnees centralisée:')
disp(Data_centered);

%Normalise the data
Data_Normlized=Data_centered./std(Dataset,0,1);
disp('La base de donnees normalisé:')
disp(Data_Normlized);

%Calculate the correlation matrix
Cov_matrix = (1 / (size(Data_Normlized, 1) - 1)) * (Data_Normlized' * Data_Normlized);
disp('La matrice de correlation:');
disp(Cov_matrix);

% Calculation of eigenvalues ​​and eigenvectors
[E, D] = eig(Cov_matrix);

% Sorting of eigenvalues ​​and eigenvectors
[D_sorted, order] = sort(diag(D), 'descend');
E_sorted = E(:, order);
disp('Vecteurs propres triés (E_sorted):');
disp(E_sorted);
disp('Valeurs propres triées (D_sorted):');
disp(D_sorted);

% Projection of data onto the first two principal components
New_data = Data_Normlized * E_sorted(:, 1:2);

%Plot the results
figure;
plot(New_data(:, 1), New_data(:, 2), '*');
for i = 1:length(villes)
    text(New_data(i, 1), New_data(i, 2), villes{i}, 'FontSize', 10, 'Color', 'blue');
end
xline(0, '--k', 'LineWidth', 0.8);
yline(0, '--k', 'LineWidth', 0.8); 
title('Projection des données sur les deux premières composantes principales');
xlabel('Composante principale 1');
ylabel('Composante principale 2');
grid on;
hold off;

%Add The new dataset d'amiens
amiens=[4.5,1.3,4.0,3.9,4.9];

%Center the amiens data
Data_amiens = amiens - mean(Dataset); 
disp('Dataset amiens center:')
disp(Data_amiens);

%Normalise the amiens data
Data_Normlized_amiens = Data_amiens ./ std(Dataset, 0, 1); 
disp('Data_Normlized_amiens :');
disp(Data_Normlized_amiens);

%Projection of new data onto the first two principal components
New_data_amiens = Data_Normlized_amiens * E_sorted(:, 1:2);
disp('New_data_amiens est:')
disp(New_data_amiens)

% Plot the results

scale_factor = 0.7; 

colors = lines(length(villes)); 

figure;
for i = 1:length(villes)
    quiver(0, 0, New_data(i, 1), New_data(i, 2), scale_factor, 'MaxHeadSize', 0.5,'Color', colors(i, :), 'LineWidth', 1.5, 'AutoScale', 'off');
    hold on;
    text(New_data(i, 1) + 0.1, New_data(i, 2) + 0.1, villes{i},'FontSize', 10, 'Color', colors(i, :), 'HorizontalAlignment', 'left');
end

plot(New_data_amiens(1), New_data_amiens(2), 'ro', 'MarkerSize', 7, 'LineWidth', 3); 
scatter(New_data_amiens(1), New_data_amiens(2), 100, 'r', 'filled');
text(New_data_amiens(1) + 0.1, New_data_amiens(2) + 0.1, 'Amiens', 'FontSize', 12,'Color', 'red', 'HorizontalAlignment', 'left');
xline(0, '--k', 'LineWidth', 0.8); 
yline(0, '--k', 'LineWidth', 0.8);
%axis([-2.5 3.5 -2.5 3.5]);
xlim([min(New_data(:, 1)) - 1, max(New_data(:, 1)) + 1]);
ylim([min(New_data(:, 2)) - 1, max(New_data(:, 2)) + 1]);
axis equal; 
grid on;
title('Projection des données sur les deux premières composantes principales avec flèches claires');
xlabel('Composante principale 1 (59.44%) ');
ylabel('Composante principale 2 (33.14%)');
hold off;


