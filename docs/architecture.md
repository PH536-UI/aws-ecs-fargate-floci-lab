# Decisões de arquitetura

## Objetivo
Praticar o ciclo de entrega de contêiner: código, imagem, registry, infraestrutura como código e orquestração de contêineres, sem depender de uma conta cloud real.

## Componentes
| Componente | Papel | Execução |
|---|---|---|
| `app/server.py` | endpoint HTTP `/health` | contêiner Docker |
| ECR | armazenamento da imagem | emulado por Floci |
| ECS cluster | agrupamento lógico da carga | emulado por Floci |
| Task definition | CPU, memória, rede e imagem | Terraform, compatível com Fargate |
| ECS service | mantém uma réplica desejada | emulado por Floci |
| GitHub Actions | valida qualidade do repositório | runner GitHub, sem deploy |

## Escolhas intencionais
- **Fargate:** task definition com `awsvpc`, `cpu = 256` e `memory = 512`.
- **Imagem mínima:** Python padrão e `python:3.12-alpine`.
- **Deploy em duas fases:** primeiro ECR, depois push da imagem e serviço.
- **CI sem credenciais:** validação no GitHub; deploy no computador que executa Floci.
- **IaC local explícito:** endpoint local e credenciais fictícias evitam AWS real.

## Critério de sucesso
`terraform apply` conclui as duas fases, a imagem aparece no ECR local e `ecs describe-services` retorna o serviço local.
