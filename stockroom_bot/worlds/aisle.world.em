<?xml version="1.0" ?>
<sdf version="1.4">
<world name="aisle">
<gui>
  <camera name="camera">
    <pose>3 -2 3.5 0.0 .85 2.4</pose>
    <view_controller>orbit</view_controller>
  </camera>
</gui>
<include><uri>model://sun</uri></include>
<include><uri>model://ground_plane</uri></include>
@{from numpy import arange}@
@{bin_count = 0}
@[for side in ['left','right']]
  @[if side == 'left']
    @{y = -1.5}
    @{yaw = 3.1415}
  @[else]
    @{y = 1.5}
    @{yaw = 0}
  @[end if]
  @[for x in arange(-1.5, 1.5, 0.5)]
    <include>
      <name>bin_@(bin_count)</name>
      <pose>@(x) @(y) 0.5 0 0 @(yaw)</pose>
      <uri>model://bin</uri>
    </include>
    <model name="bin_@(bin_count)_tag">
      <static>true</static>
      <pose>@(x) @(y*1.125) 0.63 0 0 @(yaw)</pose>
      <link name="link">
        <visual name="visual">
          <geometry><box><size>0.2 0.01 0.2</size></box></geometry>
          <material>
            <script>
              <uri>model://bin/tags</uri>
              <!--<uri>model://bin/materials/textures</uri>-->
              <name>product_@(bin_count)</name>
            </script>
          </material>
        </visual>
      </link>
    </model>
    @{bin_count += 1}
  @[end for]
@[end for]
@[def wall(p1, p2, height)]
  @{wall.count += 1}
  @[if abs(p1[0]-p2[0]) < 0.01]
    @{thickness_x = 0.1}
    @{thickness_y = abs(p1[1]-p2[1])}
  @[else]
    @{thickness_x = abs(p1[0]-p2[0])}
    @{thickness_y = 0.1}
  @[end if]
  <model name="wall_@(wall.count)">
    <static>true</static>
    <pose>@((p1[0]+p2[0])/2.) @((p1[1]+p2[1])/2.) @(height/2.) 0 0 0</pose>
    <link name="link">
      <collision name='visual'>
        <geometry>
          <box>
            <size>@(thickness_x) @(thickness_y) @(height)</size>
          </box>
        </geometry>
      </collision>
      <visual name='visual'>
        <geometry>
          <box>
            <size>@(thickness_x) @(thickness_y) @(height)</size>
          </box>
        </geometry>
      </visual>
    </link>
  </model>
@[end def]
@{wall.count = 0}
@( wall((-1.75, -1.75), ( 6.00 , -1.75), 0.7) )
@( wall((-1.75, -1.75), (-1.75,   1.75), 0.7) )
@( wall((-1.75,  1.75), ( 6.00,   1.75), 0.7) )
@( wall(( 3.00,  0.75), ( 3.00,   1.75), 0.7) )
@( wall(( 3.00, -0.75), ( 3.00,  -1.75), 0.7) )
@( wall(( 6.00, -1.75), ( 6.00,  -1.00), 0.7) )
@( wall(( 6.00,  0.00), ( 6.00,   1.75), 0.7) )
@( wall(( 5.00, -1.75), ( 5.00,   1.75), 0.7) )
  <model name="counter_top">
    <static>true</static>
    <pose>4.9 0 0.7 0 0 0</pose>
    <link name="link">
      <collision name="collision">
        <geometry><box><size>0.4 3.5 0.05</size></box></geometry>
      </collision>
      <visual name="visual">
        <geometry><box><size>0.4 3.5 0.05</size></box></geometry>
      </visual>
    </link>
  </model>
</world>
</sdf>
