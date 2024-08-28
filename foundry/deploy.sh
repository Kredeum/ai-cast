#!/bin/sh

show_help() {
  echo "Deploy smartcontract(s), if not already deployed with same args"
  echo

  echo "Usage: ./deploy.sh [OPTION]"
  echo

  echo "Option:"
  echo "   -n, --network, --chain <CHAIN> deploy to CHAIN (default: 'anvil')"
  echo "   -c, --contract <CONTRACT>      deploy only contract (default: 'all')"
  echo "   -d, --deploy-script <SCRIPT>   deploy with specific script
                                          (default: 'script/deploy/DeployAll.s.sol')"
  echo
  echo "   -s, --simulate                 simulate deployment"
  echo "   -v, --verify                   verify deployment"
  echo "   -t, --validate                 validate deployment"
  echo "   -h, --help                     this help"
  echo

  exit 0
}

CHAIN="anvil"
ACCOUNT="$ANVIL_ACCOUNT"
SENDER="$ANVIL_SENDER"
CONTRACT="all"
SCRIPT="script/deploy/DeployAll.s.sol"

while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--network)
      CHAIN="$2"
      shift
      shift
      ;;
    -s|--simulate)
      SIMULATE=1
      shift
      ;;
    -v|--verify)
      VERIFY=1
      shift
      ;;
    -t|--validate)
      VALIDATE=1
      shift
      ;;
    -h|--help)
      show_help
      ;;
    *)
      echo "Unknown arg $1"
      exit 1
      ;;
  esac
done

echo $CHAIN
echo $ACCOUNT
echo $SENDER


