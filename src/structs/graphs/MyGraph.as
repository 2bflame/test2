package structs.graphs
{

	public class MyGraph extends Graph
	{
		private var index:Array;
		public function MyGraph()
		{
			super();
			index=new Array();
		}
		
		override public function addVertex(vertex:Vertex):void
		{
			var i:int=vertex.data.i;
			var j:int=vertex.data.j;
			if(index[i]==null){
				index[i]=new Array();
			}
			index[i][j]=vertex;
			super.addVertex(vertex);
		}
		
		public function getIJ(i:int,j:int):MyVertex
		{
			return index[i][j];
		}
		
		
		
		
	}
}