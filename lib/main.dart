import 'package:flutter/material.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlassMorphismThemeProvider(
      child: MaterialApp(
        title: 'Nitin Kotasthane',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        home: const MyHomePage(title: 'Nitin Kotasthane'),
      ),
    
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
   late TabController _tabController = TabController(length: 4, vsync: this);
   final ScrollController _scrollController = ScrollController();
   final Uri _url = Uri.parse('https://growthandglory.com/');

  int _selectedBackground = 0;
  double _blurIntensity = 20.0;
  double _opacity = 0.15;
  double _glassThickness = 1.0;
  bool _enableBackgroundDistortion = true;
  bool _enableGlassBorder = true;
  Color _tintColor = Colors.blue;
  final List<String> _backgroundImages = [
    'https://picsum.photos/1200/800?random=1', // Random landscape 1
    'https://picsum.photos/1200/800?random=2', // Random landscape 2
    'https://picsum.photos/1200/800?random=3', // Random landscape 3
    'https://picsum.photos/1200/800?random=4', // Random landscape 4
    'https://picsum.photos/1200/800?random=5', // Random landscape 5
    'https://picsum.photos/1200/800?random=6', // Random landscape 6
    'https://picsum.photos/1200/800?random=7', // Random landscape 7
  ];
  final List<String> _backgroundNames = [
    'Nature 1',
    'Nature 2',
    'Nature 3',
    'Nature 4',
    'Nature 5',
    'Nature 6',
    'Nature 7',
  ];
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

 @override
  void initState() {
    super.initState();
    //_tabController = TabController(length: 3, vsync: ScrollableState());
  }
@override
  void dispose() {
    _tabController.dispose();
   // _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: _selectedBackground < _backgroundImages.length
              ? DecorationImage(
                  image: NetworkImage(_backgroundImages[_selectedBackground]),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: .3),
                    BlendMode.darken,
                  ),
                )
              : null,
          gradient: _selectedBackground >= _backgroundImages.length
              ? const RadialGradient(
                  center: Alignment.topLeft,
                  radius: 2.0,
                  colors: [
                    Color(0xFF4FC3F7), // Light blue
                    Color(0xFF29B6F6), // Medium blue
                    Color(0xFF0288D1), // Darker blue
                    Color(0xFF1976D2), // Deep blue
                    Color(0xFF303F9F), // Purple-blue
                    Color(0xFF512DA8), // Purple
                    Color(0xFF7B1FA2), // Deep purple
                    Color(0xFFAD1457), // Pink-purple
                    Color(0xFFE91E63), // Pink
                    Color(0xFFFF5722), // Red-orange
                  ],
                  stops: [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1.0],
                )
              : null,
        ),
        child: Column(
            children: <Widget>[
            GlassMorphismAppBar(
                title: Column(children:[Text('Nitin Kotasthane' ,style:TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),Text('Passionate Programmer & Architect', style: TextStyle(fontWeight:FontWeight.normal),),]),
                enableDynamicSizing: true,
                scrollController: _scrollController,
                height: 120.0,
                opacity: 0.2,
                blurIntensity: _blurIntensity,
                elevation: 2.0,
                actions: [
                //OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.lightbulb_circle_rounded,size: 60,color: Colors.white70,),label: Text("INNOVATE"),),
                //OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.architecture_rounded,size: 60,color: Colors.white70),label: Text("ARCHITECT")),
                //OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.code_off_rounded,size: 60,color: Colors.white70),label: Text("CODE")),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    setState(() {
                      _selectedBackground =
                          (_selectedBackground + 1) % (_backgroundImages.length + 1);
                    });
                  },
                ),
               ] ),
              Expanded(child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _buildConfigurationSection(),
                   //const SizedBox(height: 24),
                    _buildTabBarSection(),
            ]),
          ),
          ),
       ],
    
      
              
        ),
          
    ));
      

  }
  Widget _buildConfigurationSection() {
    return GlassMorphismCard(
      blurIntensity: _blurIntensity,
      opacity: _opacity,
      glassThickness: _glassThickness,
      enableBackgroundDistortion: _enableBackgroundDistortion,
      enableGlassBorder: _enableGlassBorder,
      tintColor: _tintColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Configuration',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),

          // Blur Intensity Slider
          Text('Blur Intensity: ${_blurIntensity.toStringAsFixed(1)}'),
          Slider(
            value: _blurIntensity,
            min: 0.0,
            max: 50.0,
            divisions: 45,
            onChanged: (value) {
              setState(() {
                _blurIntensity = value;
              });
            },
          ),

          // Opacity Slider
          Text('Opacity: ${_opacity.toStringAsFixed(2)}'),
          Slider(
            value: _opacity,
            min: 0.0,
            max: 0.5,
            divisions: 50,
            onChanged: (value) {
              setState(() {
                _opacity = value;
              });
            },
          ),

          // Glass Thickness Slider
        //  Text('Glass Thickness: ${_glassThickness.toStringAsFixed(1)}'),
          Slider(
            value: _glassThickness,
            min: 0.1,
            max: 3.0,
            divisions: 29,
            onChanged: (value) {
              setState(() {
                _glassThickness = value;
              });
            },
          ),

          // Toggle switches
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  title: const Text('Background Distortion'),
                  value: _enableBackgroundDistortion,
                  onChanged: (value) {
                    setState(() {
                      _enableBackgroundDistortion = value;
                    });
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  title: const Text('Glass Border'),
                  value: _enableGlassBorder,
                  onChanged: (value) {
                    setState(() {
                      _enableGlassBorder = value;
                    });
                  },
                ),
              ),
            ],
          ),

          // Background selector
          const SizedBox(height: 16),
          const Text('Background:'),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _backgroundImages.length + 1, // +1 for gradient option
              itemBuilder: (context, index) {
                final isGradient = index == _backgroundImages.length;
                final isSelected = _selectedBackground == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBackground = index;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 3)
                          : Border.all(color: Colors.white24, width: 1),
                      image: !isGradient
                          ? DecorationImage(
                              image: NetworkImage(_backgroundImages[index]),
                              fit: BoxFit.cover,
                            )
                          : null,
                      gradient: isGradient
                          ? const LinearGradient(
                              colors: [Color(0xFF4FC3F7), Color(0xFFFF5722)],
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        isGradient ? 'Gradient' : _backgroundNames[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Color picker
          const SizedBox(height: 16),
          const Text('Tint Color:'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              Colors.blue,
              Colors.green,
              Colors.purple,
              Colors.orange,
              Colors.red,
              Colors.teal,
              Colors.pink,
              Colors.indigo,
            ]
                .map((color) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _tintColor = color;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: _tintColor == color
                              ? Border.all(color: Colors.white, width: 3)
                              : null,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
  Widget _buildConsultingTab() {
    return GlassMorphismContainer(
      padding: const EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          SizedBox(width:100,height: 15),
          FaIcon(FontAwesomeIcons.fileContract, size: 48, color: Colors.white70),
          Text('Consulting Service  ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
          Text('Helping businesses leverage technology for growth and innovation.', style: TextStyle(color: Colors.white70),),
          SizedBox(width:100,height: 15),
          AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                child: Wrap( spacing: 8.0,runSpacing: 8.0,alignment: WrapAlignment.start,children: [ SizedBox(width:300,child: ExpansionTile(
                  collapsedBackgroundColor: Colors.blueGrey[100], // Color when collapsed
                  backgroundColor: Colors.blueGrey[300],
                  leading:FaIcon(FontAwesomeIcons.chartLine,size: 24,color: Colors.white70),
                  title: Text(
                    'CTO Advisory',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.appStore,size: 24,color: Colors.white70),
                      title: Text(
                        'Architecture Modernization',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    ListTile(
                      leading:FaIcon(FontAwesomeIcons.cubes,size: 24,color: Colors.white70),
                      title: Text(
                        'Data Science & AI Strategy',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                     ListTile(
                      leading:FaIcon(FontAwesomeIcons.robot,size: 24,color: Colors.white70),
                      title: Text(
                        'AI Engineering',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                )),
                const SizedBox(width:100,height: 16),
                SizedBox(width:300,child: ExpansionTile(
                  collapsedBackgroundColor: Colors.blueGrey[100], // Color when collapsed
                  backgroundColor: Colors.blueGrey[300],
                  leading:FaIcon(FontAwesomeIcons.boxOpen,size: 24,color: Colors.white70),
                  title: Text(
                    'Open Source Consulting',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.researchgate,size: 24,color: Colors.white70),
                      title: Text(
                        'Opensource Strategy & R & D',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    ListTile(
                      leading:FaIcon(FontAwesomeIcons.industry,size: 24,color: Colors.white70),
                      title: Text(
                        'Opensource Evaluation & Integration',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                     ListTile(
                      leading:FaIcon(FontAwesomeIcons.hireAHelper,size: 24,color: Colors.white70),
                      title: Text(
                        'Opensource Support & Training',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                )),
                const SizedBox(width:100,height: 16),
                SizedBox(width:300,child: ExpansionTile(
                  collapsedBackgroundColor: Colors.blueGrey[100], // Color when collapsed
                  backgroundColor: Colors.blueGrey[300],
                  leading:FaIcon(FontAwesomeIcons.language,size: 24,color: Colors.white70),
                  title: Text(
                    'Language Engineering',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.magnifyingGlassArrowRight,size: 24,color: Colors.white70),
                      title: Text(
                        'Migration Services',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    ListTile(
                      leading:FaIcon(FontAwesomeIcons.dev,size: 24,color: Colors.white70),
                      title: Text(
                        'DSL Dessign & Development',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                     ListTile(
                      leading:FaIcon(FontAwesomeIcons.schoolFlag,size: 24,color: Colors.white70),
                      title: Text(
                        'Language Support & Training',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                )),
                const SizedBox(width:100,height: 16),
                SizedBox(width:300,child: ExpansionTile(
                  collapsedBackgroundColor: Colors.blueGrey[100], // Color when collapsed
                  backgroundColor: Colors.blueGrey[300],
                  leading:FaIcon(FontAwesomeIcons.robot,size: 24,color: Colors.white70),
                  title: Text(
                    'AI Engineering',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.brain,size: 24,color: Colors.white70),
                      title: Text(
                        'LLM Integration',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    ListTile(
                      leading:FaIcon(FontAwesomeIcons.dev,size: 24,color: Colors.white70),
                      title: Text(
                        'LLM Customization & Fine-Tuning',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                     ListTile(
                      leading:FaIcon(FontAwesomeIcons.schoolFlag,size: 24,color: Colors.white70),
                      title: Text(
                        'LLM Support & Training',
                         style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                )),
                const SizedBox(width:100,height: 16),
                 SizedBox(width:300,child: ExpansionTile(
                  collapsedBackgroundColor: Colors.blueGrey[100], // Color when collapsed
                  backgroundColor: Colors.blueGrey[300],
                  leading:FaIcon(FontAwesomeIcons.dev,size: 24,color: Colors.white70),
                   title: Text('Freelance Development', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                      children: <Widget>[
                          ListTile(title: Text('Freelance Development in Python, Java, and Flutter,Data and AI.', style: TextStyle(color: Colors.white70),),),
            ],
          )),
          const SizedBox(width:100,height: 16),
                 SizedBox(width:300,child: ExpansionTile(
                  collapsedBackgroundColor: Colors.blueGrey[100], // Color when collapsed
                  backgroundColor: Colors.blueGrey[300],
                  leading:FaIcon(FontAwesomeIcons.cloudArrowUp,size: 24,color: Colors.white70),
                   title: Text('Cloud Architecture', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                      children: <Widget>[
                          ListTile(title: Text('End2End Cloud Architecture, Data Lake and AI Engineering.', style: TextStyle(color: Colors.white70),),),
            ],
          ))

        ]),
        )
        
        ],
      ),
    );
  } 
     Widget _buildAboutMeContent() {
    return GlassMorphismContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.person, size: 48, color: Colors.white70),
          const SizedBox(height: 16),
          Text(
            'About Me',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width:600,height:200,child: Text(
            'Passionate Programmer and Architect with expertise in AWS,Python,Rust, Java, Flutter, and AI technologies. Dedicated to driving innovation and delivering impactful solutions. I have 25 years of Solution Architecture experience.',
            style: const TextStyle(color: Colors.white70,fontSize: 16,
            fontWeight: FontWeight.bold,),
            maxLines: 5 // Limit to 2 lines
            //overflow: TextOverflow.ellipsis,
          ),),
          SizedBox(width:100,height: 5),
          Container(
               width: 200,
               height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/nitin.jpg'),
                  fit: BoxFit.cover, // Adjusts how the image fills the container
              ),
              color: Colors.white, // Background color
              borderRadius: BorderRadius.circular(15), // Rounded corners
              border: Border.all(
                 color: Colors.white,
                  width: 3,
          ),
          boxShadow: [
                 BoxShadow(
                     color: Colors.black.withValues(alpha: .5),
                     spreadRadius: 5,
                     blurRadius: 7,
                     offset: Offset(0, 3), // changes position of shadow
                   ),
              ],
                gradient: LinearGradient( // Gradient background
                colors: [Colors.blue, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
         ),
       ),
        
          ),
            SizedBox(width:100,height: 20),
            Text('Contact:kotasthanenitin644@gmail.com',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),)
          
      
      

        ],
      ),
    );
  }
     Widget _buildTrainingContent() {
    return GlassMorphismContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width:300,height: 15),
          FaIcon(FontAwesomeIcons.schoolCircleCheck, size: 48, color: Colors.white70),
          const SizedBox(width:100,height: 16),
          Text(
            'Training',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text('Inspiring youth to innovate and lead.', style: TextStyle(color: Colors.white70),),
          SizedBox(width:100,height: 15),
         AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Wrap( spacing: 8.0,runSpacing: 8.0,alignment: WrapAlignment.start,children: [ SizedBox(width:300,child: ExpansionTile(
              collapsedBackgroundColor: Colors.blueGrey[100], // Color when collapsed
              backgroundColor: Colors.blueGrey[300],
              leading:FaIcon(FontAwesomeIcons.codiepie,size: 24,color: Colors.white70),
              title: Text(
                'Programming Languages',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                SizedBox(width:100,height: 15),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.python,size: 24,color: Colors.white70),
                  title: Text(
                    'Python',
                     style: TextStyle(color: Colors.white70),
                  ),
                ),
                ListTile(
                  leading:FaIcon(FontAwesomeIcons.java,size: 24,color: Colors.white70),
                  title: Text(
                    'Java',
                     style: TextStyle(color: Colors.white70),
                  ),
                ),
                 ListTile(
                  leading:FaIcon(FontAwesomeIcons.rust,size: 24,color: Colors.white70),
                  title: Text(
                    'Rust',
                     style: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(width:100,height: 15),
              ],
            )),
            SizedBox(width:300,child: ExpansionTile(
              collapsedBackgroundColor: Colors.blueGrey[100], // Color when collapsed
              backgroundColor: Colors.blueGrey[300],
              leading:FaIcon(FontAwesomeIcons.bahai,size: 24,color: Colors.white70),
              title: Text(
                'Data Science & AI Engineering',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              children: [
                SizedBox(width:100,height: 15),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cloud,size: 24,color: Colors.white70),
                  title: Text(
                    'Cloud Data Engineering',
                     style: TextStyle(color: Colors.white70),
                  ),
                ),
                ListTile(
                  leading:FaIcon(FontAwesomeIcons.rocket,size: 24,color: Colors.white70),
                  title: Text(
                    'AI & ML Engineering',
                     style: TextStyle(color: Colors.white70),
                  ),
                ),
                 ListTile(
                  leading:FaIcon(FontAwesomeIcons.python,size: 24,color: Colors.white70),
                  title: Text(
                    'Data Science with Python',
                     style: TextStyle(color: Colors.white70),
                  ),
                ),
                SizedBox(width:100,height: 15),
              ],
            ))
            
        ]) ),
        ],
      ),
    );
  }
   Widget _buildTabContent(String title, IconData icon) {
    return GlassMorphismContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.white70),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Trusted Partners and Clients',
            style: const TextStyle(color: Colors.white70),
          ),
          GlassMorphismButton(onPressed: _launchUrl, child: Text('Growth & Glory Consulting')),
        ],
      ),
    );
  }
   Widget _buildTabBarSection() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        GlassMorphismTabBar(
          controller: _tabController,
          enableMorphing: true,
          opacity: 0.1,
          tabs: const [
            Tab(text: 'Consulting',icon:  FaIcon(FontAwesomeIcons.fileContract,  color: Colors.white70),iconMargin: EdgeInsetsGeometry.all(.5),),
            Tab(text: 'Training',icon: Icon(Icons.school_rounded),iconMargin: EdgeInsetsGeometry.all(.5),),
            Tab(text: 'Clients',icon: Icon(Icons.handshake_rounded),iconMargin: EdgeInsetsGeometry.all(.5),),
            Tab(text: 'About Me',icon: Icon(Icons.person_2_rounded),iconMargin: EdgeInsetsGeometry.all(.5),),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: screenHeight * 0.9, // 60% of screen height
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildConsultingTab(),
             _buildTrainingContent(),
              _buildTabContent('Clients', Icons.handshake_rounded),
              _buildAboutMeContent(),
            ],
          ),
        ),
      ],
    );
  }
  
}
