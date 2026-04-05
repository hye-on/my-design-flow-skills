# CLAUDE.md 디자인 섹션 템플릿

> 이 내용을 프로젝트의 CLAUDE.md에 추가하세요.

---

## 디자인 워크플로우

### 디자인 시스템
- 디자인 시스템은 `DESIGN.md`에 정의됨. UI 작업 시 반드시 먼저 읽을 것
- 모든 색상, 타이포그래피, 간격은 DESIGN.md의 토큰을 사용
- 하드코딩된 색상값 (예: `#3B82F6`, `rgb(59, 130, 246)`) 사용 금지
- Tailwind semantic class 사용 (예: `bg-primary`, `text-muted-foreground`)

### UI 컴포넌트 규칙
- 새 컴포넌트 만들기 전 `components/ui/`에 기존 컴포넌트가 있는지 확인
- shadcn/ui 컴포넌트를 우선 사용하고, 없으면 같은 패턴으로 생성
- 모든 컴포넌트는 4가지 상태를 고려: **로딩**, **에러**, **빈 상태**, **성공**
- 다크모드는 처음부터 고려 -- 나중에 추가하지 않음

### 반응형 디자인
- Mobile First로 구현
- 브레이크포인트: Mobile (<640px), Tablet (640-1024px), Desktop (1024px+)
- 모든 페이지는 모바일에서 먼저 확인

### 접근성
- 색상 대비 WCAG AA 기준 충족
- 모든 인터랙티브 요소 키보드 접근 가능
- 이미지에 alt 텍스트 필수
- 폼에 label 연결 필수

### 피드백 반영
- 디자인 피드백은 DESIGN.md 토큰 레벨로 번역하여 반영
- "이 색 좀 바꿔줘" → DESIGN.md의 해당 토큰 값 변경
- "버튼이 너무 작아" → DESIGN.md의 버튼 크기 토큰 변경

### Knowledge Base
- `knowledge-base/` 폴더의 파일들로 현재 디자인 현황 파악
- UI 작업 후 관련 knowledge-base 파일 업데이트
- `SYNC_NEEDED` 플래그가 있는 파일은 우선 업데이트
- 선택적 도구가 없으면 작업을 멈추지 말고, 3가지 선택지(설치/직접/채팅)를 제시할 것

### 워크플로우
1. DESIGN.md 읽기
2. knowledge-base 파일들로 현황 파악
3. 한 플로우를 완전히 끝내고 다음으로 (반쪽짜리 UI 금지)
4. 완성 후 knowledge-base 업데이트
