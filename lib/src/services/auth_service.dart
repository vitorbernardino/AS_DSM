import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'E-mail não encontrado. Verifique ou crie uma conta.';
      case 'wrong-password':
        return 'Senha incorreta. Tente novamente.';
      case 'invalid-email':
        return 'O formato do e-mail é inválido.';
      case 'email-already-in-use':
        return 'Este e-mail já está cadastrado.';
      case 'weak-password':
        return 'A senha deve ter pelo menos 6 caracteres.';
      case 'invalid-credential':
        return 'Credenciais inválidas. Verifique seu e-mail e senha.';
      default:
        return 'Ocorreu um erro inesperado. Tente novamente.';
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e); 
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}