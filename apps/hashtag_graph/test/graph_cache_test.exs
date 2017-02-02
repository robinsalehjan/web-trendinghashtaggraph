defmodule HashtagGraphCacheTest do
  @moduledoc false

  use ExUnit.Case

  alias HashtagGraph.GraphServer, as: GraphServer
  alias HashtagGraph.GraphCache, as: GraphCache
  alias HashtagGraph.GraphCacheSupervisor, as: GraphCacheSupervisor

   setup do
     Application.stop(:hashtag_graph)
     :ok = Application.start(:hashtag_graph)
   end

   test "initialized graph state" do
     state = GraphServer.fetch_graph
     assert Kernel.length(state) != 0
   end

   test "cache interaction" do
     {:ok, child_pid} = GraphCacheSupervisor.add_child
     assert Process.alive?(child_pid) == true

     state = GraphCache.fetch_graph(child_pid)
     assert Kernel.length(state) != 0

     assert GraphCacheSupervisor.delete_child(child_pid) == :ok
   end
end
