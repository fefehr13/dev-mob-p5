import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvra5/main.dart'; // Certifique-se de ajustar o import para o caminho real do seu aplicativo

void main() {
  testWidgets('Teste de Widget: Login e Navegação de Menu',
      (WidgetTester tester) async {
    // Construa nosso aplicativo e acione um quadro de widgets.
    await tester.pumpWidget(MyApp());

    // Verifique se a tela de login é exibida
    expect(find.text('Login'), findsOneWidget);

    // Insira o texto de e-mail e senha nos campos de entrada
    await tester.enterText(find.byType(TextField).at(0), 'seu_email');
    await tester.enterText(find.byType(TextField).at(1), 'sua_senha');

    // Toque no botão "Entrar"
    await tester.tap(find.text('Entrar'));
    await tester.pump();

    // Verifique se a tela do menu é exibida
    expect(find.text('Menu'), findsOneWidget);

    // Verifique se os botões de cadastro estão presentes
    expect(find.text('Cadastro 1'), findsOneWidget);
    expect(find.text('Cadastro 2'), findsOneWidget);
    expect(find.text('Cadastro 3'), findsOneWidget);
    expect(find.text('Cadastro 4'), findsOneWidget);

    // Você pode adicionar mais testes aqui para verificar o comportamento da navegação e interações do usuário.
  });
}
