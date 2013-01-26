package structs.graphs
{
	public class MyVertex extends Vertex
	{
		public function MyVertex(data:MyVertexData)
		{
			super(data);
		}
		
		public function set id(v:int):void
		{
			data.id=v;
		}
		
		public function get id():int
		{
			return data.id;
		}
	
		
	}
}