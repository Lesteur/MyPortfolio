class CustomKinect extends PKinect
{
  CustomKinect(PApplet p){super(p);}
  
 void onDepthFrameEvent(short[] depth_frame, byte[] player_index, float[] XYZ, float[] UV) {
    PDepthMap new_map=new PDepthMap(getDepthWidth(),getDepthHeight(),XYZ);
    if(UV!=null)
      new_map.setUV(UV);
    map=new_map;
  }
  
  void onSkeletonFrameEvent(boolean[] tracked, float[] joint_positions, float[] joint_orientations, byte[] joint_states) {
    PSkeleton[] new_skeletons=new PSkeleton[tracked.length];
   for(int i=0;i<tracked.length;i++)
      new_skeletons[i]=PSkeleton.getPSkeleton(i, tracked, joint_positions, joint_orientations,joint_states,this);
   skeletons=new_skeletons;
  }
  
  void onCOlorFrameEvent(byte[] color_data) {
    //updatePImage(video_frame,color_data);
  }

  
}
