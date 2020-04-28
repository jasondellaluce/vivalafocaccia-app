
/// Function that retrieves the integer ID of an object of the given type.
typedef TreeParentIdGetter<T> = int Function(T value);

/// Function that retrieves the integer ID of the parent of an object of the
/// given type. The parent ID is representative of a hierarchical tree structure
/// of which the object may be part.
typedef TreeValueIdGetter<T> = int Function(T value);

/// Simple tree data structure for general use. Every Tree instance is
/// considered a node, and as such can be a sub-tree. A tree with no value is
/// considered the root node, and a tree with no children is considered a
/// leaf node.
class Tree<T> {

  final T value;
  final List<Tree<T>> children;

  Tree({
    this.value,
    this.children
  });

  isRoot() => value == null;

  isLeaf() => children == null || children.length == 0;

  /// Creates a tree structure from a list of elements that specify a parent
  /// element id. If the parent specified by an element is not present in the
  /// list, then such element is added to the root node. The root node does
  /// not contain a value, and has as children the list of elements with
  /// no parent.
  factory Tree.fromListWithParentId(
      List<T> valueList,
      TreeValueIdGetter<T> idGetter,
      TreeParentIdGetter<T> parentIdGetter) {
    Tree<T> root = Tree(value : null, children : []);
    List<Tree<T>> treeList = valueList.map((e) => Tree(value: e, children: []));
    for(var tree in treeList) {
      var parentId = parentIdGetter(tree.value);
      treeList.firstWhere((e) => idGetter(e.value) == parentId,
          orElse: () => root).children.add(tree);
    }
    return root;
  }

}