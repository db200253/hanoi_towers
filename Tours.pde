final int SOURCE = 0;
final int INTER = 1;
final int DEST = 2;

class Tours {

  int n;  // number of scales
  int[][] tour;
  int[] hauteur;

  Tours(int n) {
    this.n = n;
    tour = new int[3][n];
    for (int i = 0; i < n; i++) {
      tour[SOURCE][i] = n - i;
    }
    hauteur = new int[3];
    hauteur[SOURCE] = n - 1;
    hauteur[INTER] = -1;
    hauteur[DEST] = -1;
  }
  
  // move disks
  void deplacer(int source, int destination) {
    synchronized(this) {
      if (hauteur[source] < 0)
        throw new RuntimeException("tour source vide");
      if (hauteur[destination] == n - 1)
        throw new RuntimeException("tour destination pleine");
      if (source == destination)
        throw new RuntimeException("totologie");
      if (hauteur[destination] >= 0 && tour[source][hauteur[source]] > tour[destination][hauteur[destination]])
        throw new RuntimeException("attention à la règle 2");

      hauteur[destination] += 1;
      tour[destination][hauteur[destination]] = tour[source][hauteur[source]];
      hauteur[source] -= 1;
    }
    delay(50);
  }

  synchronized void dessiner() {
    dessinerTour(SOURCE);
    dessinerTour(INTER);
    dessinerTour(DEST);
  }

  void dessinerTour(int t) {
    float h = height / n;
    float w = width / 4;

    // tower
    rectMode(CENTER);
    noStroke();
    fill(40, 80, 200);
    rect(w * (t + 1), height / 2, 20, height);

    // disks
    stroke(75, 75, 75);
    fill(0, 150, 40);
    for (int i = 0; i <= hauteur[t]; i++) {
      rect(w + (w * t), height - (i * h + h / 2), map(tour[t][i], 1, n, 40, w), h);
    }
  }
}
