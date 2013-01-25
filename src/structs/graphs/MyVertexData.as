package structs.graphs
{
	import org.as3commons.collections.framework.IComparator;

	public class MyVertexData
	{
		public var x:int;
		public var y:int;

		private var i:int;
		private var j:int;
		
		public static function indexComparator():IComparator{
			return new IndexComparator();
		}
		
		public function MyVertexData(i:int,j:int,x:int,y:int)
		{
			this.i = i;
			this.j = j;
			this.y = y;
			this.x = x;
		}
		
		public function get name():String{
			return "" + i + "," + j;
		}
	}
}	

