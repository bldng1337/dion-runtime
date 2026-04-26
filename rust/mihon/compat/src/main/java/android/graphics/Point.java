package android.graphics;

/**
 * Minimal Point stub.
 */
public class Point {
    public int x;
    public int y;
    
    public Point() {
    }
    
    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public Point(Point src) {
        this.x = src.x;
        this.y = src.y;
    }
    
    public void set(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public final boolean equals(int x, int y) {
        return this.x == x && this.y == y;
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Point point = (Point) o;
        return x == point.x && y == point.y;
    }
    
    @Override
    public int hashCode() {
        return 31 * x + y;
    }
    
    @Override
    public String toString() {
        return "Point(" + x + ", " + y + ")";
    }
}
