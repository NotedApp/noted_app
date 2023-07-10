abstract class Environment {
  void registerDependencies();
}

class LocalEnvironment extends Environment {
  @override
  void registerDependencies() {
    // TODO: implement registerDependencies
  }
}

class TestEnvironment extends Environment {
  @override
  void registerDependencies() {
    // TODO: implement registerDependencies
  }
}

class ProdEnvironment extends Environment {
  @override
  void registerDependencies() {
    throw UnimplementedError();
  }
}
