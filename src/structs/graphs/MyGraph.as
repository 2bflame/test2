package structs.graphs
{
//	import org.as3commons.collections.SortedMap;
//	import org.as3commons.collections.framework.IComparator;
//	import org.as3commons.collections.utils.NullComparator;
	import org.as3commons.collections.SortedMap;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.utils.NumericComparator;
	public class MyGraph extends Graph
	{
//		private var index:SortedMap;
		public function MyGraph()
		{
			super();
			//var indexComparator:IComparator = MyVertexData.indexComparator();
//			index=new SortedMap();
//			var map : SortedMap = new SortedMap(new NumericComparator());
		}
		
		override public function addVertex(vertex:Vertex):void
		{
			//index.add(vertex.data,vertex);
			super.addVertex(vertex);
		}
		
		
	}
}