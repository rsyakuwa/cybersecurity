# 🛡️ Script de Auditoria de Conexões e Checklist de Portas Críticas (PowerShell)

Este subprojeto contém um script automatizado em PowerShell desenvolvido para auxiliar analistas de infraestrutura, governança e operações de segurança (SecOps/Blue Team) na auditoria e verificação de conformidade (*hardening*) de rede em servidores ou estações de trabalho Windows.

O objetivo principal é mapear de forma contínua as portas lógicas ativas e fornecer uma prestação de contas completa (Checklist) sobre serviços historicamente sensíveis ou frequentemente visados por agentes maliciosos para vetores de ataque, como força bruta, varreduras (*scanning*) ou movimentação lateral (Ransomware).

## 🚀 Funcionalidades e Evoluções do Script

* **Checklist de Conformidade Completo:** Diferente de ferramentas que apenas alertam na falha, o script renderiza um quadro completo de auditoria na tela, indicando o status de cada porta monitorada (`✅ Seguro` ou `⚠️ ALERTA`), servindo como evidência de conformidade.
* **Filtragem de Alta Performance:** Coleta e centraliza as conexões de rede em memória através do cmdlet nativo `Get-NetTCPConnection` nos estados *Listen* (Ouvindo) e *Established* (Estabelecida), otimizando o cruzamento de dados via estruturas de tabelas hash.
* **Rastreabilidade Avançada (Logging Estruturado):** Criação de uma função dedicada de *logging* que gera um arquivo físico estruturado em formato de tabela (`auditoria_conexoes.log`). O log registra o carimbo de data/hora (*timestamp*) e o resultado de cada item testado para fins de auditoria posterior ou correlação em ferramentas de SIEM.
* **Tratamento de Dados Orientado a Objetos:** Utilização de `PSCustomObject` para estruturar as saídas de rede e aplicação do `Format-Table` para exibição limpa e legível no console.

## 🛠️ Matriz de Portas Críticas Monitoradas

O script avalia portas e serviços específicos que demandam atenção estrita em políticas de hardening e configuração de firewalls locais:

| Porta TCP | Serviço Monitorado | Risco Associado / Contexto de Segurança |
| :--- | :--- | :--- |
| **21** | FTP | Protocolo inseguro; tráfego de dados e credenciais em texto claro. |
| **22** | SSH | Alvo constante de ataques de força bruta se exposto externamente. |
| **23** | Telnet | Protocolo legado e altamente inseguro (sem criptografia). |
| **80** | HTTP | Tráfego web não criptografado; suscetível a interceptação de pacotes. |
| **139** | NetBIOS | Abordagem legada de resolução de nomes; risco de enumeração de rede. |
| **445** | SMB | Compartilhamento de arquivos; vetor crítico para *Ransomwares* (ex: exploits como *EternalBlue*). |
| **3389** | RDP | Acesso remoto gráfico; principal alvo de engenharia social e força bruta. |

## 📂 Estrutura das Evidências (Logs de Auditoria)

O script foi projetado para gerar expressão de conformidade e persistência local automatizada. Toda execução limpa o histórico anterior e gera uma tabela estruturada de auditoria no caminho padrão:
`C:\DLP-Quarentena\auditoria_conexoes.log`

*Exemplo do formato de saída capturado no log:*
```text
=== INÍCIO DO LOG DE AUDITORIA DE REDE ===
[ 2026-07-01 02:40:11 ] Executando varredura completa de conformidade...
[ 2026-07-01 02:40:11 ] ---------------------------------------------------------------------------------
[ 2026-07-01 02:40:11 ] Porta  | Serviço/Risco                 | Status Rede  | IP Remoto       | Resultado 
[ 2026-07-01 02:40:11 ] ---------------------------------------------------------------------------------
[ 2026-07-01 02:40:11 ] 21     | FTP (Inseguro)                | Inativa      | -               | ✅ Seguro 
[ 2026-07-01 02:40:11 ] 3389   | RDP (Vetor Força Bruta)       | Inativa      | -               | ✅ Seguro 
[ 2026-07-01 02:40:11 ] 139    | NetBIOS (Ransomware)          | Listen       | 0.0.0.0         | ⚠️ ALERTA 
[ 2026-07-01 02:40:11 ] 445    | SMB (Ransomware/EternalBlue)  | Listen       | ::              | ⚠️ ALERTA 
...
