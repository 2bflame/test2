package structs.graphs
{
	import org.as3commons.collections.framework.IComparator;

	public class MyVertexData
	{
		public var x:int;
		public var y:int;

		public var i:int;
		public var j:int;
		
		public var id:int;
		
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

