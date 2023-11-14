enum FoldState {
  None("None", 0),
  Fold("Fold", 1),
  Unfold("Unfold", 2);

  final String string;
  final int idx;
  const FoldState(this.string, this.idx);
}
