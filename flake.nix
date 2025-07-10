{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          beam27Packages.hex
          beam27Packages.rebar
          beam27Packages.rebar3
          beam27Packages.elixir
          beam27Packages.elixir-ls
        ];
      };
    }
  );
}
