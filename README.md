Instrukcja użytkowania.

Aby uruchomić symulację (przeliczyć przypadek) należy:
  1. Otworzyć plik multiple_drone_simulation.mlx
  2. Do zmiennej inputFileName przypisać nazwę pliku  (rozszerzenie .m) z scenariuszem zapisanym w folderze scenarios.
  3. Do zmiennej outputFileName przypisać nazwę  pliku (rozszerzenie .mat) do którego ma zostać zapisany wynik. Wynik zostanie zapisany pod tą nazwą pliku w folderze output.

Wyświetlenie wyników symulacji jest możliwe przy pomocy pliku app.mlapp
  1. W prawym górnym rogu wybieramy plik z wyświetalającej się listy, któa pokazuje nam wszystkie pliki z rozszerzeniem .mat z folderu output.
  2. Po uprzednim zaznaczeniu pliku klikamy load.
  3. Po kilku sekundach powinny załadować się pliki. Następnie przy pomocy suwaków można dostowsować wyświetlaną płaszczyznę oraz moment symulacji.

Obecnie w folderze output znajdują się plki:
  - bulding_simulation_data.mat -  plik zawierający przypadkowy ruch dronów z przypadkowo ustawionymi budynkami
  - scenario_1_simulation_data.mat - plik zwierający ruch 15 dronów, podzielonych na 3 typy, wzdłuż osi X. Drony danego typu znajdują się na róznych wysokościach Z. Układ budynków ma zasymulować ulicę.
  - single_drone_simulation_data - plik zaierający ruch prostoliniowy, pojedynczego drona

W folderze simulation znajdują się pliki .m , które pozwalją utworzyć i podejrzeć scnariusz, który chcemy przeliczyć. 
Aby utworzyć wsłasny scenariusz należy odpowiednio zmienić wartości przypisane zmiennym. Wszystkie zmienne są opatrzone stosownym komentarzem.
Tak przygotowany plik można następnie wykorzystać w multiple_drone_simulation.mlx
