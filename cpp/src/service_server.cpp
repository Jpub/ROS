#include <ros/ros.h>
#include <cpp/WordCount.h>


bool count(cpp::WordCount::Request &req,  // <1>
	   cpp::WordCount::Response &res) {
  size_t l = req.words.size();  // modified
  unsigned int count = 0;       // added
  if (l != 0) {  // modified
    count = 1;
    for(int i = 0; i < l; ++i)
      if (req.words[i] == ' ')
	      ++count;
  }

  res.count = count;

  return true;
}


int main(int argc, char **argv) {
  ros::init(argc, argv, "count_server");  // modified
  ros::NodeHandle node;

  ros::ServiceServer service = node.advertiseService("count", count);  // <2>

  ros::spin();  // <3>

  return 0;
}
