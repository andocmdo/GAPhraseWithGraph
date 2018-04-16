public class IndividualComparator implements Comparator<Object> {
  @Override
  public int compare(Object x, Object y) {
    Individual a = (Individual)x;
    Individual b = (Individual)y;
    return (int)( (b.getScore() - a.getScore()) * 100000 );
  }
}