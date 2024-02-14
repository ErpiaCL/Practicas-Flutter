import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'payment_config.dart';
import 'cloud_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var applePayButton = ApplePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
    paymentItems: const [
      PaymentItem(
        label: 'Item A',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Item B',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Total',
        amount: '0.02',
        status: PaymentItemStatus.final_price,
      )
    ],
    style: ApplePayButtonStyle.black,
    width: double.infinity,
    height: 50,
    type: ApplePayButtonType.buy,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems: const [
      PaymentItem(
        label: 'Total',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      )
    ],
    type: GooglePayButtonType.pay,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 212, 211, 214)),
        shadowColor: Colors.black87,
        // flexibleSpace: const Image(
        //   image: AssetImage('assets/banner.jpg'),
        //   fit: BoxFit.cover,
        // ),
        backgroundColor: const Color.fromARGB(255, 51, 48, 48),
        toolbarHeight: 100,
        actions: const [
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'ERP.IA',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 30),
            ),
          ),
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: AlignmentDirectional(0, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    '¡Bienvenido!',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: Text(
                  'Mira nuestros planes y elije el que mejor se adapte a tu negocio!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 14,
                  ),
                ),
              ),
              //-------------------------------------------------Cards de precios------------------------------------
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Theme.of(context).cardColor, // Ajusta según tu tema
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: Text('Plan Básico',
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                    ),
                    const Text('20 USD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 29, 127, 255))),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                      child: Text(
                          'Este plan ofrece las funcionalidades basicas de ERP.IA para que pruebes lo que te podemos ofrecer!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 10),
                      child: GooglePayButton(
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(
                                defaultGooglePay),
                        paymentItems: const [
                          PaymentItem(
                            label: 'Total',
                            amount: '20.0',
                            status: PaymentItemStatus.final_price,
                          )
                        ],
                        type: GooglePayButtonType.pay,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: (result) =>
                            debugPrint('Payment Result $result'),
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //--------------------------------------------------------Plan estandar-------------------------------------------
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Theme.of(context).cardColor, // Ajusta según tu tema
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: Text('Plan Estandar',
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                    ),
                    const Text('240 USD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 29, 127, 255))),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                      child: Text(
                          'Este plan ofrece funcionalidades mas avanzadas de ERP.IA para que te adentres en nuestra automatizacion de servicios!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 10),
                      child: GooglePayButton(
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(
                                defaultGooglePay),
                        paymentItems: const [
                          PaymentItem(
                            label: 'Total',
                            amount: '240.0',
                            status: PaymentItemStatus.final_price,
                          )
                        ],
                        type: GooglePayButtonType.pay,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: (result) =>
                            debugPrint('Payment Result $result'),
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //-------------------------------------------------------Plan Profesional------------------------------------------------------------
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Theme.of(context).cardColor, // Ajusta según tu tema
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: Text('Plan Profesional',
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                    ),
                    const Text('540 USD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 29, 127, 255))),
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                      child: Text(
                          'Libera toda las funciones de ERP.IA y empieza a administrar y autoatizar tu empreza con la totalidad de nuestros servicios!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 77, 77, 77))),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 10),
                      child: GooglePayButton(
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(
                                defaultGooglePay),
                        paymentItems: const [
                          PaymentItem(
                            label: 'Total',
                            amount: '540.0',
                            status: PaymentItemStatus.final_price,
                          )
                        ],
                        type: GooglePayButtonType.pay,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: (result) =>
                            debugPrint('Payment Result $result'),
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //------------------------------------------------------Fin de las cards-------------------------------------------------------------
              const Align(
                alignment: AlignmentDirectional(0, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    '¿Que es ERP.IA?',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: Text(
                  'Nuestro software ofrece sólidas funcionalidades de gestión de proyectos. Permite a consultores como yo planificar, ejecutar y supervisar proyectos meticulosamente definiendo tareas, estableciendo cronogramas, asignando recursos y monitoreando de cerca el progreso.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 14,
                  ),
                ),
              ),
              const Align(
                alignment: AlignmentDirectional(0, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    '¿Porque ERP.IA?',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: Text(
                  'Además, nuestro software incorpora sofisticadas herramientas de gestión de relaciones con los clientes (CRM). Me permite mantener un depósito centralizado de información del cliente, realizar un seguimiento de las interacciones, gestionar historiales de comunicación y capturar detalles vitales del cliente.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 14,
                  ),
                ),
              ),
              const Align(
                alignment: AlignmentDirectional(0, -1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    'Nuestro Objetivo',
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: Text(
                  'Nuestra plataforma integra potentes capacidades de análisis e informes. Esto me permite generar informes detallados, analizar métricas de desempeño del proyecto y obtener información útil. Identificar áreas de mejora, realizar un seguimiento de los indicadores clave de rendimiento (KPI) y brindar recomendaciones estratégicas a los clientes, agregando un valor significativo a nuestros servicios de consultoría.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //--------------------------------------------Boton de subida de archivos-----------------------------------------------------
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Llama a la función aquí
                    callCloudFunctionWithPdf();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // background (button) color
                  ),
                  child: const Text(
                    'Subir archivo',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //-----------------------------------------Fin de subida de archivos-------------------------------------------------------------------
            ],
          ),
        ),
      ),
      //Menú desplegable
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 51, 48, 48),
              ),
              child: Text(
                'ERP.IA Panel',
                style: TextStyle(
                    color: Color.fromARGB(255, 221, 221, 221),
                    fontWeight: FontWeight.w300),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.assured_workload_outlined),
              title: Text('Facturas'),
            ),
            const ListTile(
              leading: Icon(Icons.bakery_dining),
              title: Text('Bancos'),
            ),
            const ListTile(
              leading: Icon(Icons.analytics),
              title: Text('Análisis'),
            ),
            const ListTile(
              leading: Icon(Icons.incomplete_circle_outlined),
              title: Text('Marketing'),
            ),
            const ListTile(
              leading: Icon(Icons.approval_outlined),
              title: Text('Aprobaciones'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute<ProfileScreen>(
                    builder: (context) => ProfileScreen(
                      appBar: AppBar(
                        title: const Text(
                          'Perfil',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: const Color.fromARGB(255, 51, 48, 48),
                        elevation: 15,
                      ),
                      actions: [
                        SignedOutAction((context) {
                          Navigator.of(context).pop();
                        })
                      ],
                      children: const [
                        Divider(),
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: Text(
                                'ERP.Ia',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              },
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                } catch (e) {
                  print("Error al cerrar sesión: $e");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
