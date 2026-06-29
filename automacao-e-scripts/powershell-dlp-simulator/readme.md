# 🛡️ Data Loss Prevention (DLP) Simulator: Identificação de PII e Remediação Automática

![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat-square&logo=powershell&logoColor=white)

Este repositório apresenta um laboratório prático focado em Engenharia de Detecção, Compliance e Governança de Dados. O projeto simula o comportamento de um agente de **DLP (Data Loss Prevention)** corporativo, realizando inspeção profunda de arquivos (Deep Content Inspection) para mitigar o vazamento de informações sensíveis.

---

## 📋 Cenário e Objetivo

Em conformidade com legislações de privacidade como a **LGPD (Lei Geral de Proteção de Dados)**, as organizações precisam garantir que dados pessoais sensíveis ou propriedades intelectuais não fiquem expostos em diretórios públicos ou de rede sem controle de acesso adequado.

O objetivo deste script é automatizar a varredura contínua de um diretório de arquivos (`Data at Rest`), analisar o conteúdo interno de cada documento através de expressões regulares (**Regex**) e aplicar uma **remediação imediata (isolamento em quarentena)** caso uma política de segurança seja violada.

---

## 🛠️ Tecnologias e Conceitos Utilizados

*   **Ambiente de Execução:** Windows PowerShell (Modo Administrador)
*   **Inspeção de Conteúdo:** Expressões Regulares (Regex) para mapeamento de padrões estruturados.
*   **Conceito de Segurança:** Governança de Dados, Proteção de PII (*Personally Identifiable Information*) e Mitigação de Riscos Corporativos.

---

## 🚀 Engenharia de Detecção: As Regras de Negócio

O simulador analisa os arquivos baseando-se em duas regras de governança críticas:

1.  **Proteção à Privacidade (LGPD):** Identificação de strings que correspondam à estrutura padrão de um **CPF** (`\b\d{3}\.\d{3}\.\d{3}-\d{2}\b`).
2.  **Proteção de Propriedade Intelectual:** Varredura em busca de marcadores de classificação de informação confidenciais, como os termos `CONFIDENCIAL`, `SENHA` ou `SEGREDOCORPORATIVO`.

---

## 💻 Código do Simulador

O script executa um loop de verificação, lê os dados internos sem alterar os metadados do arquivo original e executa o isolamento lógico caso encontre irregularidades:

```powershell
# === CONFIGURAÇÃO DO AGENTE DLP LOCAL ===
$DiretorioMonitorado = "C:\DLP-Test-Folder"
$PastaQuarentena    = "C:\DLP-Quarentena"

# Cria os diretórios caso não existam
if (!(Test-Path $DiretorioMonitorado)) { New-Item -ItemType Directory -Path $DiretorioMonitorado | Out-Null }
if (!(Test-Path $PastaQuarentena))    { New-Item -ItemType Directory -Path $PastaQuarentena | Out-Null }

# Expressões Regulares (Regex) para identificar vazamento de informação
$Padrao_CPF  = "\b\d{3}\.\d{3}\.\d{3}-\d{2}\b" 
$Padrao_Info = "CONFIDENCIAL|SEGREDOCORPORATIVO|SENHA"

Write-Host "=== AGENTE DLP ATIVADO: MONITORANDO $DiretorioMonitorado ===" -ForegroundColor Cyan

# Varredura dos arquivos na pasta
$Arquivos = Get-ChildItem -Path $DiretorioMonitorado -File

foreach ($Arquivo in $Arquivos) {
    $Conteudo = Get-Content -Path $Arquivo.FullName -Raw
    $Vulneravel = $false
    $Motivo = ""

    # Regra 1: Validação de Dados Pessoais (LGPD / PII)
    if ($Conteudo -match $Padrao_CPF) {
        $Vulneravel = $true
        $Motivo = "Dados Pessoais Sensíveis Detectados (Formato CPF)"
    }
    # Regra 2: Validação de Propriedade Intelectual
    elseif ($Conteudo -match $Padrao_Info) {
        $Vulneravel = $true
        $Motivo = "Classificação de Informação Violada (Termo Confidencial)"
    }

    # === AÇÃO DE REMEDIAÇÃO DO DLP ===
    if ($Vulneravel) {
        Write-Host "[VIOLAÇÃO DE POLÍTICA] O arquivo '$($Arquivo.Name)' viola as diretrizes de segurança!" -ForegroundColor Red
        Write-Host "-> Motivo: $Motivo" -ForegroundColor Yellow
        Write-Host "-> Ação: Movendo ativo para a Quarentena de Segurança." -ForegroundColor DarkYellow
        
        # Move o arquivo para isolamento (Mitigação do Risco)
        Move-Item -Path $Arquivo.FullName -Destination (Join-Path $PastaQuarentena $Arquivo.Name) -Force
        Write-Host "--------------------------------------------------------"
    } else {
        Write-Host "[COMPLIANCE OK] Arquivo '$($Arquivo.Name)' verificado e liberado." -ForegroundColor Green
    }
}
```

## 🎯 Validação Prática em Laboratório

Após colocar o script em execução e adicionar arquivos de teste no diretório simulado, a saída no console valida a eficácia das regras, separando arquivos em conformidade daqueles que dispararam o gatilho de quarentena:



---
## 🧠 Conceitos de Cibersegurança Aplicados

Remediação Automatizada: Reduz drasticamente o tempo de exposição do dado (Window of Vulnerability). Em ambientes reais, o arquivo é retirado de circulação no exato segundo em que é detectado.

Isolamento Analítico (Quarentena): Mover o arquivo para um diretório restrito preserva a evidência para investigações posteriores do time de Resposta a Incidentes (IR) e SecOps, sem interromper o fluxo de trabalho do restante do servidor.

Engenharia de Compliance: O projeto une conhecimentos de infraestrutura (Manipulação de arquivos via CLI) com os pilares de Governança, Riscos e Compliance (GRC), aplicando regras de negócio diretamente na proteção de ativos técnicos.

Aviso Legal: Este simulador foi desenvolvido estritamente para fins educacionais e de demonstração de arquitetura defensiva de dados corporativos.
