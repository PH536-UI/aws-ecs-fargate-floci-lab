# Custos e segurança

## Custo deste laboratório
O desenho padrão não cria recursos em AWS. Floci, Docker e Terraform executam localmente. Portanto, não há cobrança da AWS por esta execução.

## Por que a distinção importa
Em AWS real, ECS em Fargate cobra CPU/memória enquanto a tarefa executa. EKS possui também uma tarifa por cluster, além dos nós. Este repositório não deve ser apresentado como prova de custos ou operação produtiva em AWS.

## Regras de segurança
1. Nunca alterar `floci_endpoint` para uma conta AWS sem revisão manual.
2. Nunca versionar chaves, tokens, `.env` ou arquivos de estado Terraform.
3. Usar somente dados de demonstração no app e nas evidências.
4. Executar `destroy-local.sh` após os testes.
5. Revisar o plano Terraform antes de adaptar a cloud real.
