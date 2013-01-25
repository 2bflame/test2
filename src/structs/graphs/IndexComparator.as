package structs.graphs
{
	import org.as3commons.collections.framework.IComparator;
	
	public class IndexComparator implements IComparator {
		
		public function compare(item1 : *, item2 : *) : int {
			if (item1.i < item2.i)return -1;
			if (item1.i > item2.i) return 1;
			if (item1.j < item2.j)return -1;
			if (item1.j > item2.j) return 1;
			
			return 0;
		}
	}
}