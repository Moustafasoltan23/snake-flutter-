import 'package:flutter/material.dart';

class welcome_screen extends StatelessWidget {
  const welcome_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 61, 67),
      appBar: AppBar(
        backgroundColor: Colors.black,
        shadowColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                width: 160,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "image/welcome${index + 1}.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16),
                                image: const DecorationImage(
                                    image: AssetImage("image/welcome1.jpg"),
                                    fit: BoxFit.fill)),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: const Text(
                                    "Welcome to Snake Robot",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "About us",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "The snake robot s an exciting development in the field of robotics, drawing inspiration from the natural movement of snakes, The aim of this project is to create a robot that can efficiently navigate through difficult and tight environments, making it ideal for use in exploring hard-to-reach areas such as disaster rubble or complex industrial environments,The snake robot is characterized by its flexible design, which allows it to bend and twist almost continuously, enabling it to easily overcome obstacles and tight spaces. The robot utilizes serpentine motion, moving by bending its successive sections and propelling them using internal motors ,Additionally, the snake robot can be equipped with a variety of sensors such as cameras, remote sensors, and thermal sensors, allowing it to effectively analyze its environment and provide accurate data to the user ,Using these technologies, the snake robot can perform various tasks such as search and rescue, inspection in factories and industrial facilities, and even surveillance and reconnaissance in hazardous areas. The development of the snake robot project represents a significant advancement in the field of robotics and opens up new possibilities for practical applications in a variety of fields",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
