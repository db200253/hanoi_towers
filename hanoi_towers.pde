Tours tours;

PImage back;

void setup() {
  size(800, 400);
  back = loadImage("bg.jpg");
  back.resize(width, height);
  tours = new Tours(4);
}

void draw() {
  background(back);
  tours.dessiner();
}

// launch the resolution of the problem by clicking
void mouseClicked() {
  thread("hanoiEnParallele");
}

// resolve recursively hanoi towers problem
void hanoi(int n, int source, int destination, int intermediaire) {
  if(n > 0) {
    hanoi(n - 1, source, intermediaire, destination);
    tours.deplacer(source, destination);
    hanoi(n - 1, intermediaire, destination, source);
  }
}

void hanoiEnParallele() {
  hanoi(tours.n, SOURCE, DEST, INTER);
}
