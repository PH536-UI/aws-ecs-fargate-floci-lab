# Evidência sanitizada: deploy local ECS

- Data da execução: 25 de outubro de 2026.
- Ambiente: Linux/WSL, Docker Desktop e Floci local.
- Endpoint do emulador: `http://localhost:4566`.
- Conta/região emuladas: `000000000000` / `us-east-1`.

## Resultado retornado pelo ECS emulado

| Campo | Valor |
| --- | --- |
| Serviço | `ph-ecs-fargate-lab-app` |
| Estado | `ACTIVE` |
| Cluster | `ph-ecs-fargate-lab-cluster` |
| Launch type | `FARGATE` |
| Tasks desejadas | `1` |
| Tasks em execução | `1` |
| Tasks pendentes | `0` |
| Rollout | `COMPLETED` |
| Evento | `has reached a steady state` |

## Limite da evidência

Este registro comprova o resultado do fluxo local emulado. Não comprova implantação, desempenho, disponibilidade, custos, observabilidade ou controles de segurança em AWS real. Nenhuma credencial real foi incluída neste arquivo.
